# file_utils.jl - Adaptación de file_utils.py a Julia

using Dates

function monitorear_log(file_path::String)
    last_size = 0
    println("Archivo encontrado. Esperando nuevos logs...")
    while true
        try
            if isfile(file_path)
                size = filesize(file_path)
                if size > last_size
                    open(file_path, "r") do f
                        seek(f, last_size)
                        for line in eachline(f)
                            println(strip(line))
                        end
                        last_size = position(f)
                    end
                end
            else
                println("Archivo $file_path no existe. Esperando...")
            end
            sleep(1)
        catch e
            println("Error monitoreando archivo: $e")
            sleep(2)
        end
    end
end
