# main.jl - Adaptación de main.py a Julia

using Printf
using Dates
include("utils/docker_utils.jl")
include("utils/k8s_utils.jl")
include("utils/file_utils.jl")
include("utils/config_loader.jl")

function read_from_docker()
    print("Nombre/ID del contenedor Docker: ")
    container_name = readline()
    logs = get_docker_logs(container_name, 50)
    println("\n===== LOGS DOCKER =====")
    println(logs)
end

function read_from_k8s()
    print("Nombre del pod en Kubernetes: ")
    pod_name = readline()
    print("Namespace (default si vacío): ")
    namespace = readline()
    if isempty(namespace)
        namespace = "default"
    end
    logs = get_k8s_pod_logs(pod_name, namespace, 50)
    println("\n===== LOGS KUBERNETES =====")
    println(logs)
end

function read_from_file()
    print("Ruta del fichero de logs: ")
    file_path = readline()
    try
        lines = readlines(file_path)
        logs = join(lines[max(end-49,1):end], "\n")
        println("\n===== LOGS FICHERO =====")
        println(logs)
    catch e
        println("[ERROR] No se pudieron leer los logs del fichero $file_path: $e")
    end
end

function monitor_file_realtime()
    print("Ruta del fichero de logs a monitorear: ")
    file_path = readline()
    if isempty(strip(file_path))
        println("Error: No se proporcionó ninguna ruta")
        return
    end
    println("Monitoreando: $file_path")
    println("Presiona Ctrl+C para volver al menú")
    try
        monitorear_log(file_path)
    catch e
        println("Error monitoreando archivo: $e")
    end
end

function monitor_external_app()
    rutas_comunes = ["../otro-repositorio/logs/app.log", "../otro-repositorio/output.log", "./logs/external.log"]
    # Implementación pendiente
end

# Puedes agregar el menú principal aquí si lo necesitas
