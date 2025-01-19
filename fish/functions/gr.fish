function gr
    if test (git rev-parse --is-inside-work-tree 2>/dev/null)
        cd (git rev-parse --show-toplevel)
    else
        echo "Not in a Git repository"
    end
end
