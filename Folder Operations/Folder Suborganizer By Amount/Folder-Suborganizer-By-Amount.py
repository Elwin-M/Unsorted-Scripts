import os
import shutil
import argparse

def create_subdirectories(src_dir, files_per_directory):
    if not os.path.exists(src_dir):
        print(f"Source directory '{src_dir}' does not exist.")
        return

    parent_dir = os.path.basename(src_dir)
    files = os.listdir(src_dir)
    files.sort()

    total_files = len(files)
    if total_files == 0:
        print(f"No files found in '{src_dir}'.")
        return

    num_directories = (total_files + files_per_directory - 1) // files_per_directory

    for i in range(num_directories):
        start = i * files_per_directory
        end = (i + 1) * files_per_directory
        files_in_range = files[start:end]

        subdirectory_name = f"{parent_dir} [{i * files_per_directory + 1:03d}-{min((i + 1) * files_per_directory, total_files):03d}]"
        subdirectory_path = os.path.join(src_dir, subdirectory_name)

        os.makedirs(subdirectory_path, exist_ok=True)

        for file_name in files_in_range:
            src_file = os.path.join(src_dir, file_name)
            dest_file = os.path.join(subdirectory_path, file_name)

            shutil.move(src_file, dest_file)
            print(f"Moved '{file_name}' to '{subdirectory_name}'.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create subdirectories for files in a directory.")
    parser.add_argument("-p", "--path", type=str, default=os.getcwd(), help="Source directory path (default: current directory)")
    parser.add_argument("-i", "--items", type=int, default=50, help="Number of items per subdirectory (default: 50)")
    args = parser.parse_args()

    source_directory = args.path
    items_per_subdirectory = args.items
    
    print(f"\nSource directory: {source_directory}")
    print(f"Items per subdirectory: {items_per_subdirectory} \n")

    confirmation = input("Do you want to proceed? (yes or enter to confirm, any other key to cancel): ")
    if confirmation.lower() in ["yes", "y", ""]:
        create_subdirectories(source_directory, items_per_subdirectory)
    else:
        print("Script execution aborted.")
