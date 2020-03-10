resource r1 {
    protocol C;
    meta-disk internal;
    device    /dev/drbd0;
    disk      /dev/mapper/Backup--SFTP-srv;
    net {
        #allow-two-primaries;
        cram-hmac-alg "sha1";
        shared-secret "Axians";
        after-sb-0pri discard-zero-changes;
        after-sb-1pri discard-secondary;
        after-sb-2pri disconnect;
        rr-conflict violently;
    }

    startup {
        wfc-timeout 60;
        #become-primary-on both;
    }

    syncer {
        rate 1000M;
    }
    on vmbackup01 { address 192.168.50.79:7789; }
    on vmbackup02 { address 192.168.50.84:7789; }
}