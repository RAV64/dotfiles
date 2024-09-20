function watch --argument path --argument command
    watchexec --restart --stop-signal SIGKILL --watch $path $command
end
