
header_type ethernet_t {
    fields {
        dst : 48;
        src : 48;
        ether_type : 16;
    }
}

header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        total_len : 16;
        identification : 16;
        flags : 3;
        frag_offset : 13;
        ttl : 8;
        protocol : 8;
        hdr_checksum : 16;
        src : 32;
        dst: 32;
    }
}

header_type arp_ipv4_t {
    fields {
        src_mac : 48;
        src_ip : 32;
        dst_mac : 48;
        dst_ip : 32;
    }
}

header ethernet_t ethernet;
header ipv4_t ipv4;
header arp_ipv4_t arp;
