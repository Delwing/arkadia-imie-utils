imie.update = imie.update or {}

function imie.update:fix(name)
    self:backup(name)
    local lines = {}
    local start_line, end_line
    local line_index = 1
    for line in io.lines(scripts.config_loader:get_config_path(name)) do
        if line == "------------     OD TEGO MIEJSCA W DOL MOZNA ZMIENIAC ZAWARTOSC    --------------" then
            start_line = line_index + 2
        end
        if line == "------------       OD TEGO MIEJSCA PONIZEJ NIC NIE ZMIENIAJ       ---------------" then
            end_line = line_index - 2
        end
        table.insert(lines, line)
        line_index = line_index + 1
    end

    if start_line and end_line then
        local destination = io.open(scripts.config_loader:get_config_path(name), "w")
        for i = start_line, end_line do
            destination:write(lines[i] .. "\n")
        end
        destination:close()
        scripts:print_log("Plik " .. name .. ".txt zostal zaktualizowany")

    else
        scripts:print_log("Nie moge zaktualizowac pliku " .. name .. ".txt, wykonaj aktualizacje recznie")
    end
end

function imie.update:backup(name)
    local source = io.open(scripts.config_loader:get_config_path(name), "r")
    local content = source:read("*a")
    source:close()
    local destination = io.open(scripts.config_loader:get_config_path(name .. "_backup"), "w")
    destination:write(content)
    destination:close()
end