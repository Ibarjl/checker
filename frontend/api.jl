# api.jl - Adaptación de api.py a Julia
using Dates

function get_status()
    return [
        Dict(
            "name" => "Avionics",
            "status" => "OK",
            "last_error" => nothing,
            "restarts_last_hour" => 1,
            "last_checked" => Dates.format(now(), "yyyy-mm-dd HH:MM:SS")
        ),
        Dict(
            "name" => "Asset API",
            "status" => "ERROR",
            "last_error" => "ConnectionTimeout",
            "restarts_last_hour" => 2,
            "last_checked" => Dates.format(now(), "yyyy-mm-dd HH:MM:SS")
        )
    ]
end
