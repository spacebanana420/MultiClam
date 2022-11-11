## What is multiclam
ClamAV's clamscan singlethreaded utility is fast, but it could be faster if it was multithreaded.

Multiclam creates multiple clamscan instances to divide the scanning work across the desired amount of threads.

It is not 100% perfect as clamscan has a "build time" before starting to scan files, so it will take the same time to scan 1 file as it would to scan 30 files in 1 row. For this reason in multiclam each scan instance scans not 1 but multiple files, whose amount can either be automatically defined (default) or manually set by the user.

Multiclam works best on directories with a big amount of files/folders.
