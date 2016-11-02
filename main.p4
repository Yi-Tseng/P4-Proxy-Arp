include "table.p4"

control ingress {

    if(valid(ipv4)) {
        apply(learn_from_ip);
    } else if (valid(arp)) {
        apply(learn_from_arp);

        if(arp.dst_ip == 0xffffffff) {
            // Arp Request
            apply(req_arp);
        }
    }
}
