function clean-repos
    for dir in */
        set dir (string trim -r -c '/' -- $dir)

        if not test -d $dir
            continue
        end

        echo
        echo "Checking $dir ..."

        if not test -d "$dir/.git"
            echo "  Not a git repo, skipping."
            continue
        end

        pushd $dir > /dev/null

        # update remote info (optional)
        git fetch --all --prune > /dev/null 2>&1

        # working tree + index clean?
        git diff --quiet
        set wc_status $status
        git diff --quiet --cached
        set idx_status $status

        set status_clean 1
        if test $wc_status -eq 0 -a $idx_status -eq 0
            set status_clean 0
        end

        # current branch
        set branch (git symbolic-ref --short HEAD 2>/dev/null)

        set rel_status 1
        if test -n "$branch"
            # upstream, if any
            set upstream (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

            if test -n "$upstream"
                # ahead/behind counts
                set counts (git rev-list --left-right --count $upstream...$branch 2>/dev/null)
                if test $status -eq 0
                    set behind (echo $counts | awk '{print $1}')
                    set ahead (echo $counts | awk '{print $2}')
                    if test $ahead -eq 0 -a $behind -eq 0
                        set rel_status 0
                    end
                end
            end
        end

        if test $status_clean -eq 0 -a $rel_status -eq 0
            echo "  Repo is clean and up to date with upstream."
            read -l -P "  Delete directory '$dir'? [y/N] " ans
            switch (string lower -- $ans)
                case y yes
                    popd > /dev/null
                    echo "  Deleting $dir ..."
                    rm -rf -- $dir
                    continue
                case '*'
                    echo "  Skipping $dir."
            end
        else
            echo "  Has local changes or not fully pushed, skipping."
        end

        popd > /dev/null
    end
end
