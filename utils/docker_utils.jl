# docker_utils.jl - Adaptación de docker_utils.py a Julia

function get_docker_logs(container_name::String, tail::Int=100)::String
    try
        cmd = `docker logs --tail=$(tail) $(container_name)`
        logs = read(cmd, String)
        return logs
    catch e
        return "[ERROR] No se pudieron obtener los logs del contenedor $container_name: $e"
    end
end

function stream_docker_logs(container_name::String)
    try
        cmd = `docker logs -f $(container_name)`
        for line in eachline(cmd)
            println(line)
        end
    catch e
        println("[ERROR] No se pudo hacer streaming de logs del contenedor $container_name: $e")
    end
end
