# libs/file_recovery.py
import pytsk3
import os

def scan_deleted_files(image_path):
    """Function to scan for deleted files using pytsk3."""
    
    # Open disk image using pytsk3
    img_info = pytsk3.Img_Info(image_path)
    
    # Open the root directory of the filesystem
    fs_info = pytsk3.FS_Info(img_info)
    
    # Traverse the file system to find deleted files
    files = []
    
    def directory_traversal(directory):
        for entry in directory:
            if entry.info.name.name in [b'.', b'..']:
                continue
            
            try:
                file_name = entry.info.name.name.decode('utf-8')
            except UnicodeDecodeError:
                continue

            # Check if the file is deleted
            if entry.info.meta and entry.info.meta.flags & pytsk3.TSK_FS_META_FLAG_UNALLOC:
                files.append(file_name)
            
            # If it's a directory, recursively scan it
            if entry.info.meta.type == pytsk3.TSK_FS_META_TYPE_DIR:
                sub_directory = entry.as_directory()
                directory_traversal(sub_directory)

    directory_traversal(fs_info.open_dir("/"))
    
    return files
