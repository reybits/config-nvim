## Disable Plugins

You can disable the plugins by creating a disabled.lua file with the content:

```
return {
    { "some-useless/plugin_1", enabled = false },
    { "some-useless/plugin_2", enabled = false },
}
```

## Configure Plugins

Or you can change its configuration by creating a plugname.lua file with the content:

```
return {
    "some-useful/plugin",
    opts = {
        -- options
    },
}
```
