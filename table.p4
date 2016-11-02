#include "header.p4"
#include "metadata.p4"
#include "register.p4"


table learn_from_ip {
    actions {
        action_learn_from_ip;
    }
}

action action_learn_from_ip() {
    register_read(temp_meta.temp_index, arp_index, 0);
    register_write(arp_mac, temp_meta.temp_index, eth.src);
    register_write(arp_ip, temp_meta.temp_index, ipv4.src);
    add_to_field(temp_meta.temp_index, 1);
}

table learn_from_arp {
    actions {
        action_learn_from_arp;
    }
}

action action_learn_from_arp() {
    register_read(temp_meta.temp_index, arp_index, 0);
    register_write(arp_mac, temp_meta.temp_index, arp.src);
    register_write(arp_ip, temp_meta.temp_index, arp.src);
    add_to_field(temp_meta.temp_index, 1);
}

table req_arp {
    reads {
        arp.dst_ip: exact;
    }

    actions {
        action_req_arp;
    }
}

action action_req_arp(hw_addr) {
    modify_field(temp_meta.temp_mac, arp.srcHwAddr);
    modify_field(temp_meta.temp_ip, arp.srcIpAddr);

    modify_field(arp.srcHwAddr, hw_addr);
    modify_field(arp.srcIpAddr, dstIpAddr);

    modify_field(arp.dstHwAddr, temp_meta.temp_mac);
    modify_field(arp.dstIpAddr, temp_meta.temp_ip);

    modify_field(standard_metadata.egress_spec, standard_metadata.in_port);
}
