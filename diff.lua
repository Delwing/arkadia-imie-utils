imie.diff = imie.diff or {
    dir = getMudletHomeDir() .. "/plugins/arkadia-imie-utils/"
}

imie.diff.file_url = "file:///" .. imie.diff.dir .. "/display/index.html"

function imie.diff:get_files(name)
    local config_file = io.open(scripts.config_loader:get_config_path(name), "r")
    local config_content = config_file:read("*all")
    config_file:close()

    local source = io.open(getMudletHomeDir() .. "/arkadia/imie.txt", "r")
    local source_content = source:read("*a")
    source:close()

    local configs = {
        current = config_content,
        source = source_content
    }

    local fileName = self.dir .. "display/configs.js"
    file = io.open (fileName, "w+")
    file:write("configs = ")
    file:write(yajl.to_string(configs))
    file:close()
end

function imie.diff:open(name)
    self:get_files(name)
    openUrl(self.file_url)
end

