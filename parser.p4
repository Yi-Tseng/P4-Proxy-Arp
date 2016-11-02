#include "header.p4"
#define ETHERTYPE_IPV4 0x0800
#define ETHERTYPE_ARP  0x0806

parser start {
    return parse_ethernet;
}

parser parse_ethernet {
    extract(ethernet);
    return select(latest.etherType) {
        ETHERTYPE_IPV4 : parse_ipv4;
        ETHERTYPE_ARP : parse_arp;
    }
}

parser parse_ipv4 {
    extract(ipv4);
    return ingress;
}

parser parse_arp {
    extract(arp);
    return ingress;
}
