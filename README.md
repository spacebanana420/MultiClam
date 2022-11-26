## What is MultiClam
ClamAV's clamscan singlethreaded utility is fast, but it could be faster if it was multithreaded.

MultiClam creates multiple clamscan instances to divide the scanning work across the desired amount of threads.

It is not 100% perfect as clamscan has a "build time" before starting to scan files, so it will take the same time to scan 1 file as it would to scan 30 files in 1 row with 1 thread. For this reason, in multiclam each instance scans not 1 but multiple files, whose amount can either be automatically calculated (default) or manually set by the user through the configuration inside the script.

Multiclam works best on directories with a big amount of files.
