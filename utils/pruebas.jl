# pruebas.jl - Adaptación de pruebas.py a Julia

using Dates
using Random

function generar_logs_test(archivo_log::String="test.log", duracion_segundos::Int=60)
    println("🔧 Generando logs en: $archivo_log")
    if duracion_segundos > 0
        println("⏰ Duración: $duracion_segundos segundos")
    else
        println("♾️  Duración: Infinita (Ctrl+C para detener)")
    end
    mensajes = [
        "INFO: Aplicación iniciada correctamente",
        "DEBUG: Procesando solicitud de usuario #12345",
        "WARNING: Memoria alta detectada (85% uso)",
        "ERROR: Conexión a base de datos falló - reintentando...",
        "INFO: Usuario 'admin' autenticado exitosamente",
        "ERROR: Timeout en servicio externo (api.ejemplo.com)",
        "INFO: Operación de backup completada",
        "DEBUG: Cache invalidado correctamente",
        "WARNING: Disco con 90% de capacidad",
        "INFO: 15 usuarios conectados simultáneamente",
        "ERROR: Falló validación de datos en endpoint /api/users",
        "INFO: Tarea programada ejecutada exitosamente"
    ]
    open(archivo_log, "w", encoding="UTF-8") do f
        write(f, "=== LOG INICIADO $(Dates.format(now(), "yyyy-mm-dd HH:MM:SS")) ===\n")
    end
    tiempo_inicio = time()
    contador = 1
    while true
        if duracion_segundos > 0 && (time() - tiempo_inicio) >= duracion_segundos
            break
        end
        mensaje = mensajes[rand(1:length(mensajes))]
        timestamp = Dates.format(now(), "yyyy-mm-dd HH:MM:SS")
        linea_log = "[$timestamp] $mensaje (#$(lpad(string(contador),4,'0')))\n"
        open(archivo_log, "a", encoding="UTF-8") do f
            write(f, linea_log)
        end
        contador += 1
        sleep(rand(0.5:0.1:2.0))
    end
end
