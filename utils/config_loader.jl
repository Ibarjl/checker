# config_loader.jl - Adaptación de config_loader.py a Julia

using JSON
using Printf

function cargar_configuracion_repositorios()
    config_path = "config/monitor_config.json"
    try
        open(config_path, "r", encoding="UTF-8") do f
            config = JSON.parse(read(f, String))
            return config
        end
    catch e
        @printf("Archivo de configuración no encontrado: %s\n", config_path)
        return nothing
    end
end

function listar_repositorios_disponibles()
    config = cargar_configuracion_repositorios()
    if config === nothing
        return []
    end
    repositorios = []
    for (key, repo) in config["repositorios"]
        push!(repositorios, Dict(
            "id" => key,
            "nombre" => get(repo, "nombre", key),
            "ruta" => get(repo, "ruta_logs", ""),
            "descripcion" => get(repo, "descripcion", "Sin descripción")
        ))
    end
    return repositorios
end

function detectar_logs()
    directorios = ["./logs", "../logs", "./", "../"]
    repositorios_detectados = Dict()
    for directorio in directorios
        if isdir(directorio)
            for archivo in readdir(directorio)
                if endswith(archivo, ".log")
                    repo_id = replace(archivo, ".log" => "")
                    repositorios_detectados[repo_id] = Dict(
                        "nombre" => "Auto: $repo_id",
                        "ruta_logs" => joinpath(directorio, archivo),
                        "descripcion" => "Detectado automáticamente en $directorio"
                    )
                end
            end
        end
    end
    return repositorios_detectados
end
