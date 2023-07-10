function note
    set -l date (date +"/%Y/%m/%d/")
    set -l time (date +"%H:%M")
    set -l note_folder ~/notes
    set -l note_file $time.md

    if test (count $argv) -gt 0
        set note_file $argv[1].md
    end

    if not test -d $note_folder
        git clone https://github.com/RAV64/notes $note_folder
    end

    set -l file $note_folder$date$note_file

    mkdir -p $note_folder$date

    v $file

    if test -s $file
        git -C $note_folder add .
        git -C $note_folder commit -m "Update $date$note_file"
        git -C $note_folder push
    end
end
