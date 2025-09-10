# k8s_utils.jl - Adaptación de k8s_utils.py a Julia

function get_k8s_pod_logs(pod_name::String, namespace::String="default", tail::Int=100)::String
    try
        cmd = `kubectl logs --tail=$(tail) -n $(namespace) $(pod_name)`
        logs = read(cmd, String)
        return logs
    catch e
        return "[ERROR] No se pudieron obtener los logs del pod $pod_name: $e"
    end
end

function stream_k8s_pod_logs(pod_name::String, namespace::String="default")
    try
        cmd = `kubectl logs -f -n $(namespace) $(pod_name)`
        for line in eachline(cmd)
            println(line)
        end
    catch e
        println("[ERROR] No se pudo hacer streaming de logs del pod $pod_name: $e")
    end
end
