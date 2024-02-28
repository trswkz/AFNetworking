#!/bin/bash

# Created with reference below
# https://gist.github.com/MarcoEidinger/22feb1588c3d7be41c42853a77e52772

# https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api
searchTerms=(
    # Swift
    ## File timestamp APIs
    "creationDate"
    "modificationDate"
    "fileModificationDate"
    "contentModificationDateKey"
    "creationDateKey"
    "getattrlist"
    "getattrlistbulk"
    "fgetattrlist"
    "stat"
    "fstat"
    "fstatat"
    "lstat"
    "getattrlistat"
    ## System boot time APIs
    "systemUptime"
    "mach_absolute_time"
    ## Disk space APIs
    "volumeAvailableCapacityKey"
    "volumeAvailableCapacityForImportantUsageKey"
    "volumeAvailableCapacityForOpportunisticUsageKey"
    "volumeTotalCapacityKey"
    "systemFreeSize"
    "systemSize"
    "statfs"
    "statvfs"
    "fstatfs"
    "fstatvfs"
    "getattrlist"
    "fgetattrlist"
    "getattrlistat"
    ## Active keyboard APIs
    "activeInputModes"
    ## User defaults APIs
    "UserDefaults"
    # Objc
    ## File timestamp APIs
    NSFileCreationDate
    NSFileModificationDate
    fileModificationDate
    NSURLContentModificationDateKey
    NSURLCreationDateKey
    getattrlist
    getattrlistbulk
    fgetattrlist
    stat
    fstat
    fstatat
    lstat
    getattrlistat
    ## System boot time APIs
    systemUptime
    mach_absolute_time
    ## Disk space APIs
    NSURLVolumeAvailableCapacityKey
    NSURLVolumeAvailableCapacityForImportantUsageKey
    NSURLVolumeAvailableCapacityForOpportunisticUsageKey
    NSURLVolumeTotalCapacityKey
    NSFileSystemFreeSize
    NSFileSystemSize
    statfs
    statvfs
    fstatfs
    fstatvfs
    getattrlist
    fgetattrlist
    getattrlistat
    ## Active keyboard APIs
    activeInputModes
    ## User defaults APIs
    NSUserDefaults
)
search_dir="$1"

if [ -z "$search_dir" ]; then
    echo "Usage: $0 <search_dir>"
    exit 1
fi

for pattern in "${searchTerms[@]}"; do
    results=`find "$search_dir" -type f \( -name "*.swift" -o -name "*.m" \) -exec grep -Hn -Fw "$pattern" {} + | awk -F ':' -v OFS='\t' '{ print $1,$2,$3 }'`
    while read line
    do
    echo "${pattern}\t${line}"
    done <<< "${results}"
done
