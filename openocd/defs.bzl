def _openocd_flash_impl(ctx):
    # Write firmware to memory location 0x8000000 i.e. start of executable flash
    interface_config_string = ""
    for config in ctx.attr.interface_configs:
        interface_config_string = interface_config_string + " -f " + config
    chip_config_string = ""
    for config in ctx.attr.device_configs:
        chip_config_string = chip_config_string + " -f " + config
    transport_string = ""
    if ctx.attr.transport:
        transport_string = "-c \"transport select %s\"" % (ctx.attr.transport)
    script_template = """
{openocd} {interface_config_string} {transport_string} {chip_config_string} -c "adapter_khz {programmer_frequency}; program {firmware} verify reset exit {flash_offset}"
"""
    script = ctx.actions.declare_file("%s.sh" % ctx.label.name)

    script_content = script_template.format(
        openocd = ctx.file._openocd.short_path,
        interface_config_string = interface_config_string,
        chip_config_string = chip_config_string,
        firmware = ctx.file.image.short_path,
        flash_offset = ctx.attr.flash_offset,
        programmer_frequency = ctx.attr.programmer_frequency,
        transport_string = transport_string,
    )
    ctx.actions.write(script, script_content, is_executable = True)
    runfiles = ctx.runfiles(files = [ctx.file._openocd, ctx.file.image])
    return [DefaultInfo(executable = script, runfiles = runfiles)]

openocd_flash = rule(
    implementation = _openocd_flash_impl,
    doc = """
Used to flash a binary image to a microcontroller using openocd

Example:
    openocd_flash(
        name = "main_flash",
        device_configs = [
            "target/stm32h7x_dual_bank.cfg",
        ],
        image = ":main",
        interface_configs = [
            "interface/stlink.cfg",
        ],
        transport = "hla_swd",
    )
""",
    attrs = {
        "image": attr.label(
            doc = "Binary image to flash",
            mandatory = True,
            allow_single_file = True,
        ),
        "interface_configs": attr.string_list(
            doc = "openocd config path for interface, note that user defined configs are not supported at this time",
        ),
        "device_configs": attr.string_list(
            doc = "openocd config path for chip/board, note that user defined configs are not suppported at this time",
        ),
        "flash_offset": attr.string(
            doc = "The starting point of the flash memory",
            mandatory = False,
            default = "0x8000000",
        ),
        "_openocd": attr.label(
            doc = "Executable for flashing",
            default = "@com_openocd//:openocd",
            allow_single_file = True,
        ),
        "programmer_frequency": attr.string(
            doc = "The programming frequency of the adapter",
            default = "24000",
            mandatory = False,
        ),
        "transport": attr.string(
            doc = "Debugger transport interface",
            default = "hla_swd",
            mandatory = False,
        ),
    },
    executable = True,
)
