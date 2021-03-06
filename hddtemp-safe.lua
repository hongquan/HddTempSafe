#!/usr/bin/env lua5.3

local argparse = require "argparse"
local socket = require "socket"
local luxio = require "luxio"

local DEFAULT_PORT = 7634

local function log_error(msg_template, ...)
    io.stderr:write(string.format(msg_template .. "\n", table.unpack(arg)))
end

local function main ()
    local parser = argparse("hddtemp-safe", "Get HDD temperature from hddtemp daemon")
    parser:option("-p --port", string.format("hddtemp's listening port (default %d)", DEFAULT_PORT), DEFAULT_PORT)
    parser:argument("disk", "Disk path, e.g. /dev/sda")

    local args = parser:parse()
    local port = args.port

    local s, _ = luxio.stat(args.disk)

    if s ~= 0 then
        log_error("%s does not exist!", args.disk)
        os.exit(-1)
    end

    local client = socket.tcp()
    client:settimeout(1)
    local sk = client:connect('127.0.0.1', port)
    if sk == nil then
        log_error("Failed to connect to hddtemp daemon. Did you configured it to run as daemon?")
        os.exit(-2)
    end
    local content, err = client:receive('*a')
    client:close()
    if content == nil then
        -- No data from hddtemp
        print("")
        return
    end
    -- Sample response from hddtemp: |/dev/sda|ST1000LM035-1RK172|37|C||/dev/sdb|KINGSTON SA400M8120G|36|C|
    local pattern = "|" .. args.disk .. "|[- %w]+|(%d*)|([CF*])|"
    local temp, unit = content:match(pattern)
    print(temp)
end

main()
