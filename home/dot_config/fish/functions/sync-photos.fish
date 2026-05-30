function sync-photos
    set local_dir "/Volumes/Baymax/Photography Archives"
    set remote_dir "s3://soyka-photo-archives"

    # Make sure the local directory exists (currently attached)
    if test -d $local_dir
        echo "Found local directory $local_dir. Starting sync..."
    else
        echo "Local directory $local_dir not found. Is Baymax plugged in?"
        return 1
    end

    echo "Cleaning ._ files..."
    dot_clean $local_dir

    echo "Cleaning .DS_Store files..."
    find $local_dir -name ".DS_Store" -delete

    echo "Backing up to AWS S3..."
    set -lx LDFLAGS "-L/opt/homebrew/opt/expat/lib $LDFLAGS"
    set -lx CPPFLAGS "-I/opt/homebrew/opt/expat/include $CPPFLAGS"
    set -lx DYLD_LIBRARY_PATH "/opt/homebrew/opt/expat/lib:$DYLD_LIBRARY_PATH"
    aws s3 sync $local_dir $remote_dir

    echo "Sync complete!"
end
