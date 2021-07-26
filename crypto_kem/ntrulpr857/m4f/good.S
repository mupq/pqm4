
#include "macros.S"
#include "special_butterflies.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_Good_64x27
.type __asm_Good_64x27, %function
__asm_Good_64x27:
    push {r4-r12, lr}
    ldr.w r14, [sp, #40]

    add.w r12, r0, #3456

    vmov.w s0, s1, r14, r12

    vldm r1, {s4-s10}

    vmov.w r14, s0
    ldrsh.w r4, [r14, #0]
    ldrsh.w r5, [r14, #1296]
    ldrsh.w r7, [r14, #432]
    ldrsh.w r10, [r14, #864]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #0]
    str.w r5, [r0, #864]
    str.w r6, [r0, #1728]
    str.w r7, [r0, #2592]
    str.w r8, [r1, #0]
    str.w r9, [r1, #864]
    str.w r10, [r1, #1728]
    str.w r11, [r1, #2592]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #272]
    ldrsh.w r6, [r14, #1568]
    ldrsh.w r8, [r14, #704]
    ldrsh.w r11, [r14, #1136]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #4]
    str.w r5, [r0, #868]
    str.w r6, [r0, #1732]
    str.w r7, [r0, #2596]
    str.w r8, [r1, #4]
    str.w r9, [r1, #868]
    str.w r10, [r1, #1732]
    str.w r11, [r1, #2596]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1408]
    ldrsh.w r6, [r14, #544]
    ldrsh.w r9, [r14, #976]
    ldrsh.w r11, [r14, #112]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #8]
    str.w r5, [r0, #872]
    str.w r6, [r0, #1736]
    str.w r7, [r0, #2600]
    str.w r8, [r1, #8]
    str.w r9, [r1, #872]
    str.w r10, [r1, #1736]
    str.w r11, [r1, #2600]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #384]
    ldrsh.w r5, [r14, #1680]
    ldrsh.w r7, [r14, #816]
    ldrsh.w r10, [r14, #1248]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #12]
    str.w r5, [r0, #876]
    str.w r6, [r0, #1740]
    str.w r7, [r0, #2604]
    str.w r8, [r1, #12]
    str.w r9, [r1, #876]
    str.w r10, [r1, #1740]
    str.w r11, [r1, #2604]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #656]
    ldrsh.w r8, [r14, #1088]
    ldrsh.w r10, [r14, #224]
    ldrsh.w r11, [r14, #1520]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #16]
    str.w r5, [r0, #880]
    str.w r6, [r0, #1744]
    str.w r7, [r0, #2608]
    str.w r8, [r1, #16]
    str.w r9, [r1, #880]
    str.w r10, [r1, #1744]
    str.w r11, [r1, #2608]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #928]
    ldrsh.w r8, [r14, #64]
    ldrsh.w r9, [r14, #1360]
    ldrsh.w r11, [r14, #496]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #20]
    str.w r5, [r0, #884]
    str.w r6, [r0, #1748]
    str.w r7, [r0, #2612]
    str.w r8, [r1, #20]
    str.w r9, [r1, #884]
    str.w r10, [r1, #1748]
    str.w r11, [r1, #2612]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #768]
    ldrsh.w r7, [r14, #1200]
    ldrsh.w r9, [r14, #336]
    ldrsh.w r10, [r14, #1632]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #24]
    str.w r5, [r0, #888]
    str.w r6, [r0, #1752]
    str.w r7, [r0, #2616]
    str.w r8, [r1, #24]
    str.w r9, [r1, #888]
    str.w r10, [r1, #1752]
    str.w r11, [r1, #2616]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1040]
    ldrsh.w r7, [r14, #176]
    ldrsh.w r8, [r14, #1472]
    ldrsh.w r10, [r14, #608]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #28]
    str.w r5, [r0, #892]
    str.w r6, [r0, #1756]
    str.w r7, [r0, #2620]
    str.w r8, [r1, #28]
    str.w r9, [r1, #892]
    str.w r10, [r1, #1756]
    str.w r11, [r1, #2620]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #16]
    ldrsh.w r6, [r14, #1312]
    ldrsh.w r8, [r14, #448]
    ldrsh.w r11, [r14, #880]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #32]
    str.w r5, [r0, #896]
    str.w r6, [r0, #1760]
    str.w r7, [r0, #2624]
    str.w r8, [r1, #32]
    str.w r9, [r1, #896]
    str.w r10, [r1, #1760]
    str.w r11, [r1, #2624]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1152]
    ldrsh.w r6, [r14, #288]
    ldrsh.w r7, [r14, #1584]
    ldrsh.w r9, [r14, #720]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #36]
    str.w r5, [r0, #900]
    str.w r6, [r0, #1764]
    str.w r7, [r0, #2628]
    str.w r8, [r1, #36]
    str.w r9, [r1, #900]
    str.w r10, [r1, #1764]
    str.w r11, [r1, #2628]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #128]
    ldrsh.w r5, [r14, #1424]
    ldrsh.w r7, [r14, #560]
    ldrsh.w r10, [r14, #992]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #40]
    str.w r5, [r0, #904]
    str.w r6, [r0, #1768]
    str.w r7, [r0, #2632]
    str.w r8, [r1, #40]
    str.w r9, [r1, #904]
    str.w r10, [r1, #1768]
    str.w r11, [r1, #2632]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #400]
    ldrsh.w r6, [r14, #1696]
    ldrsh.w r8, [r14, #832]
    ldrsh.w r11, [r14, #1264]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #44]
    str.w r5, [r0, #908]
    str.w r6, [r0, #1772]
    str.w r7, [r0, #2636]
    str.w r8, [r1, #44]
    str.w r9, [r1, #908]
    str.w r10, [r1, #1772]
    str.w r11, [r1, #2636]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1536]
    ldrsh.w r6, [r14, #672]
    ldrsh.w r9, [r14, #1104]
    ldrsh.w r11, [r14, #240]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #48]
    str.w r5, [r0, #912]
    str.w r6, [r0, #1776]
    str.w r7, [r0, #2640]
    str.w r8, [r1, #48]
    str.w r9, [r1, #912]
    str.w r10, [r1, #1776]
    str.w r11, [r1, #2640]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #512]
    ldrsh.w r7, [r14, #944]
    ldrsh.w r9, [r14, #80]
    ldrsh.w r10, [r14, #1376]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #52]
    str.w r5, [r0, #916]
    str.w r6, [r0, #1780]
    str.w r7, [r0, #2644]
    str.w r8, [r1, #52]
    str.w r9, [r1, #916]
    str.w r10, [r1, #1780]
    str.w r11, [r1, #2644]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #784]
    ldrsh.w r8, [r14, #1216]
    ldrsh.w r10, [r14, #352]
    ldrsh.w r11, [r14, #1648]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #56]
    str.w r5, [r0, #920]
    str.w r6, [r0, #1784]
    str.w r7, [r0, #2648]
    str.w r8, [r1, #56]
    str.w r9, [r1, #920]
    str.w r10, [r1, #1784]
    str.w r11, [r1, #2648]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1056]
    ldrsh.w r8, [r14, #192]
    ldrsh.w r9, [r14, #1488]
    ldrsh.w r11, [r14, #624]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #60]
    str.w r5, [r0, #924]
    str.w r6, [r0, #1788]
    str.w r7, [r0, #2652]
    str.w r8, [r1, #60]
    str.w r9, [r1, #924]
    str.w r10, [r1, #1788]
    str.w r11, [r1, #2652]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #896]
    ldrsh.w r6, [r14, #32]
    ldrsh.w r7, [r14, #1328]
    ldrsh.w r9, [r14, #464]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #64]
    str.w r5, [r0, #928]
    str.w r6, [r0, #1792]
    str.w r7, [r0, #2656]
    str.w r8, [r1, #64]
    str.w r9, [r1, #928]
    str.w r10, [r1, #1792]
    str.w r11, [r1, #2656]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1168]
    ldrsh.w r7, [r14, #304]
    ldrsh.w r8, [r14, #1600]
    ldrsh.w r10, [r14, #736]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #68]
    str.w r5, [r0, #932]
    str.w r6, [r0, #1796]
    str.w r7, [r0, #2660]
    str.w r8, [r1, #68]
    str.w r9, [r1, #932]
    str.w r10, [r1, #1796]
    str.w r11, [r1, #2660]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #144]
    ldrsh.w r6, [r14, #1440]
    ldrsh.w r8, [r14, #576]
    ldrsh.w r11, [r14, #1008]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #72]
    str.w r5, [r0, #936]
    str.w r6, [r0, #1800]
    str.w r7, [r0, #2664]
    str.w r8, [r1, #72]
    str.w r9, [r1, #936]
    str.w r10, [r1, #1800]
    str.w r11, [r1, #2664]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1280]
    ldrsh.w r6, [r14, #416]
    ldrsh.w r7, [r14, #1712]
    ldrsh.w r9, [r14, #848]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #76]
    str.w r5, [r0, #940]
    str.w r6, [r0, #1804]
    str.w r7, [r0, #2668]
    str.w r8, [r1, #76]
    str.w r9, [r1, #940]
    str.w r10, [r1, #1804]
    str.w r11, [r1, #2668]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #256]
    ldrsh.w r5, [r14, #1552]
    ldrsh.w r7, [r14, #688]
    ldrsh.w r10, [r14, #1120]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #80]
    str.w r5, [r0, #944]
    str.w r6, [r0, #1808]
    str.w r7, [r0, #2672]
    str.w r8, [r1, #80]
    str.w r9, [r1, #944]
    str.w r10, [r1, #1808]
    str.w r11, [r1, #2672]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #528]
    ldrsh.w r8, [r14, #960]
    ldrsh.w r10, [r14, #96]
    ldrsh.w r11, [r14, #1392]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #84]
    str.w r5, [r0, #948]
    str.w r6, [r0, #1812]
    str.w r7, [r0, #2676]
    str.w r8, [r1, #84]
    str.w r9, [r1, #948]
    str.w r10, [r1, #1812]
    str.w r11, [r1, #2676]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1664]
    ldrsh.w r6, [r14, #800]
    ldrsh.w r9, [r14, #1232]
    ldrsh.w r11, [r14, #368]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #88]
    str.w r5, [r0, #952]
    str.w r6, [r0, #1816]
    str.w r7, [r0, #2680]
    str.w r8, [r1, #88]
    str.w r9, [r1, #952]
    str.w r10, [r1, #1816]
    str.w r11, [r1, #2680]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #640]
    ldrsh.w r7, [r14, #1072]
    ldrsh.w r9, [r14, #208]
    ldrsh.w r10, [r14, #1504]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #92]
    str.w r5, [r0, #956]
    str.w r6, [r0, #1820]
    str.w r7, [r0, #2684]
    str.w r8, [r1, #92]
    str.w r9, [r1, #956]
    str.w r10, [r1, #1820]
    str.w r11, [r1, #2684]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #912]
    ldrsh.w r7, [r14, #48]
    ldrsh.w r8, [r14, #1344]
    ldrsh.w r10, [r14, #480]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #96]
    str.w r5, [r0, #960]
    str.w r6, [r0, #1824]
    str.w r7, [r0, #2688]
    str.w r8, [r1, #96]
    str.w r9, [r1, #960]
    str.w r10, [r1, #1824]
    str.w r11, [r1, #2688]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1184]
    ldrsh.w r8, [r14, #320]
    ldrsh.w r9, [r14, #1616]
    ldrsh.w r11, [r14, #752]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #100]
    str.w r5, [r0, #964]
    str.w r6, [r0, #1828]
    str.w r7, [r0, #2692]
    str.w r8, [r1, #100]
    str.w r9, [r1, #964]
    str.w r10, [r1, #1828]
    str.w r11, [r1, #2692]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1024]
    ldrsh.w r6, [r14, #160]
    ldrsh.w r7, [r14, #1456]
    ldrsh.w r9, [r14, #592]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #104]
    str.w r5, [r0, #968]
    str.w r6, [r0, #1832]
    str.w r7, [r0, #2696]
    str.w r8, [r1, #104]
    str.w r9, [r1, #968]
    str.w r10, [r1, #1832]
    str.w r11, [r1, #2696]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1026]
    ldrsh.w r6, [r14, #162]
    ldrsh.w r7, [r14, #1458]
    ldrsh.w r9, [r14, #594]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #108]
    str.w r5, [r0, #972]
    str.w r6, [r0, #1836]
    str.w r7, [r0, #2700]
    str.w r8, [r1, #108]
    str.w r9, [r1, #972]
    str.w r10, [r1, #1836]
    str.w r11, [r1, #2700]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #2]
    ldrsh.w r5, [r14, #1298]
    ldrsh.w r7, [r14, #434]
    ldrsh.w r10, [r14, #866]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #112]
    str.w r5, [r0, #976]
    str.w r6, [r0, #1840]
    str.w r7, [r0, #2704]
    str.w r8, [r1, #112]
    str.w r9, [r1, #976]
    str.w r10, [r1, #1840]
    str.w r11, [r1, #2704]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #274]
    ldrsh.w r6, [r14, #1570]
    ldrsh.w r8, [r14, #706]
    ldrsh.w r11, [r14, #1138]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #116]
    str.w r5, [r0, #980]
    str.w r6, [r0, #1844]
    str.w r7, [r0, #2708]
    str.w r8, [r1, #116]
    str.w r9, [r1, #980]
    str.w r10, [r1, #1844]
    str.w r11, [r1, #2708]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1410]
    ldrsh.w r6, [r14, #546]
    ldrsh.w r9, [r14, #978]
    ldrsh.w r11, [r14, #114]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #120]
    str.w r5, [r0, #984]
    str.w r6, [r0, #1848]
    str.w r7, [r0, #2712]
    str.w r8, [r1, #120]
    str.w r9, [r1, #984]
    str.w r10, [r1, #1848]
    str.w r11, [r1, #2712]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #386]
    ldrsh.w r5, [r14, #1682]
    ldrsh.w r7, [r14, #818]
    ldrsh.w r10, [r14, #1250]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #124]
    str.w r5, [r0, #988]
    str.w r6, [r0, #1852]
    str.w r7, [r0, #2716]
    str.w r8, [r1, #124]
    str.w r9, [r1, #988]
    str.w r10, [r1, #1852]
    str.w r11, [r1, #2716]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #658]
    ldrsh.w r8, [r14, #1090]
    ldrsh.w r10, [r14, #226]
    ldrsh.w r11, [r14, #1522]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #128]
    str.w r5, [r0, #992]
    str.w r6, [r0, #1856]
    str.w r7, [r0, #2720]
    str.w r8, [r1, #128]
    str.w r9, [r1, #992]
    str.w r10, [r1, #1856]
    str.w r11, [r1, #2720]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #930]
    ldrsh.w r8, [r14, #66]
    ldrsh.w r9, [r14, #1362]
    ldrsh.w r11, [r14, #498]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #132]
    str.w r5, [r0, #996]
    str.w r6, [r0, #1860]
    str.w r7, [r0, #2724]
    str.w r8, [r1, #132]
    str.w r9, [r1, #996]
    str.w r10, [r1, #1860]
    str.w r11, [r1, #2724]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #770]
    ldrsh.w r7, [r14, #1202]
    ldrsh.w r9, [r14, #338]
    ldrsh.w r10, [r14, #1634]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #136]
    str.w r5, [r0, #1000]
    str.w r6, [r0, #1864]
    str.w r7, [r0, #2728]
    str.w r8, [r1, #136]
    str.w r9, [r1, #1000]
    str.w r10, [r1, #1864]
    str.w r11, [r1, #2728]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1042]
    ldrsh.w r7, [r14, #178]
    ldrsh.w r8, [r14, #1474]
    ldrsh.w r10, [r14, #610]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #140]
    str.w r5, [r0, #1004]
    str.w r6, [r0, #1868]
    str.w r7, [r0, #2732]
    str.w r8, [r1, #140]
    str.w r9, [r1, #1004]
    str.w r10, [r1, #1868]
    str.w r11, [r1, #2732]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #18]
    ldrsh.w r6, [r14, #1314]
    ldrsh.w r8, [r14, #450]
    ldrsh.w r11, [r14, #882]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #144]
    str.w r5, [r0, #1008]
    str.w r6, [r0, #1872]
    str.w r7, [r0, #2736]
    str.w r8, [r1, #144]
    str.w r9, [r1, #1008]
    str.w r10, [r1, #1872]
    str.w r11, [r1, #2736]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1154]
    ldrsh.w r6, [r14, #290]
    ldrsh.w r7, [r14, #1586]
    ldrsh.w r9, [r14, #722]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #148]
    str.w r5, [r0, #1012]
    str.w r6, [r0, #1876]
    str.w r7, [r0, #2740]
    str.w r8, [r1, #148]
    str.w r9, [r1, #1012]
    str.w r10, [r1, #1876]
    str.w r11, [r1, #2740]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #130]
    ldrsh.w r5, [r14, #1426]
    ldrsh.w r7, [r14, #562]
    ldrsh.w r10, [r14, #994]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #152]
    str.w r5, [r0, #1016]
    str.w r6, [r0, #1880]
    str.w r7, [r0, #2744]
    str.w r8, [r1, #152]
    str.w r9, [r1, #1016]
    str.w r10, [r1, #1880]
    str.w r11, [r1, #2744]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #402]
    ldrsh.w r6, [r14, #1698]
    ldrsh.w r8, [r14, #834]
    ldrsh.w r11, [r14, #1266]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #156]
    str.w r5, [r0, #1020]
    str.w r6, [r0, #1884]
    str.w r7, [r0, #2748]
    str.w r8, [r1, #156]
    str.w r9, [r1, #1020]
    str.w r10, [r1, #1884]
    str.w r11, [r1, #2748]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1538]
    ldrsh.w r6, [r14, #674]
    ldrsh.w r9, [r14, #1106]
    ldrsh.w r11, [r14, #242]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #160]
    str.w r5, [r0, #1024]
    str.w r6, [r0, #1888]
    str.w r7, [r0, #2752]
    str.w r8, [r1, #160]
    str.w r9, [r1, #1024]
    str.w r10, [r1, #1888]
    str.w r11, [r1, #2752]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #514]
    ldrsh.w r7, [r14, #946]
    ldrsh.w r9, [r14, #82]
    ldrsh.w r10, [r14, #1378]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #164]
    str.w r5, [r0, #1028]
    str.w r6, [r0, #1892]
    str.w r7, [r0, #2756]
    str.w r8, [r1, #164]
    str.w r9, [r1, #1028]
    str.w r10, [r1, #1892]
    str.w r11, [r1, #2756]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #786]
    ldrsh.w r8, [r14, #1218]
    ldrsh.w r10, [r14, #354]
    ldrsh.w r11, [r14, #1650]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #168]
    str.w r5, [r0, #1032]
    str.w r6, [r0, #1896]
    str.w r7, [r0, #2760]
    str.w r8, [r1, #168]
    str.w r9, [r1, #1032]
    str.w r10, [r1, #1896]
    str.w r11, [r1, #2760]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1058]
    ldrsh.w r8, [r14, #194]
    ldrsh.w r9, [r14, #1490]
    ldrsh.w r11, [r14, #626]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #172]
    str.w r5, [r0, #1036]
    str.w r6, [r0, #1900]
    str.w r7, [r0, #2764]
    str.w r8, [r1, #172]
    str.w r9, [r1, #1036]
    str.w r10, [r1, #1900]
    str.w r11, [r1, #2764]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #898]
    ldrsh.w r6, [r14, #34]
    ldrsh.w r7, [r14, #1330]
    ldrsh.w r9, [r14, #466]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #176]
    str.w r5, [r0, #1040]
    str.w r6, [r0, #1904]
    str.w r7, [r0, #2768]
    str.w r8, [r1, #176]
    str.w r9, [r1, #1040]
    str.w r10, [r1, #1904]
    str.w r11, [r1, #2768]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1170]
    ldrsh.w r7, [r14, #306]
    ldrsh.w r8, [r14, #1602]
    ldrsh.w r10, [r14, #738]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #180]
    str.w r5, [r0, #1044]
    str.w r6, [r0, #1908]
    str.w r7, [r0, #2772]
    str.w r8, [r1, #180]
    str.w r9, [r1, #1044]
    str.w r10, [r1, #1908]
    str.w r11, [r1, #2772]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #146]
    ldrsh.w r6, [r14, #1442]
    ldrsh.w r8, [r14, #578]
    ldrsh.w r11, [r14, #1010]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #184]
    str.w r5, [r0, #1048]
    str.w r6, [r0, #1912]
    str.w r7, [r0, #2776]
    str.w r8, [r1, #184]
    str.w r9, [r1, #1048]
    str.w r10, [r1, #1912]
    str.w r11, [r1, #2776]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1282]
    ldrsh.w r6, [r14, #418]
    ldrsh.w r9, [r14, #850]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #188]
    str.w r5, [r0, #1052]
    str.w r6, [r0, #1916]
    str.w r7, [r0, #2780]
    str.w r8, [r1, #188]
    str.w r9, [r1, #1052]
    str.w r10, [r1, #1916]
    str.w r11, [r1, #2780]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #258]
    ldrsh.w r5, [r14, #1554]
    ldrsh.w r7, [r14, #690]
    ldrsh.w r10, [r14, #1122]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #192]
    str.w r5, [r0, #1056]
    str.w r6, [r0, #1920]
    str.w r7, [r0, #2784]
    str.w r8, [r1, #192]
    str.w r9, [r1, #1056]
    str.w r10, [r1, #1920]
    str.w r11, [r1, #2784]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #530]
    ldrsh.w r8, [r14, #962]
    ldrsh.w r10, [r14, #98]
    ldrsh.w r11, [r14, #1394]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #196]
    str.w r5, [r0, #1060]
    str.w r6, [r0, #1924]
    str.w r7, [r0, #2788]
    str.w r8, [r1, #196]
    str.w r9, [r1, #1060]
    str.w r10, [r1, #1924]
    str.w r11, [r1, #2788]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1666]
    ldrsh.w r6, [r14, #802]
    ldrsh.w r9, [r14, #1234]
    ldrsh.w r11, [r14, #370]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #200]
    str.w r5, [r0, #1064]
    str.w r6, [r0, #1928]
    str.w r7, [r0, #2792]
    str.w r8, [r1, #200]
    str.w r9, [r1, #1064]
    str.w r10, [r1, #1928]
    str.w r11, [r1, #2792]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #642]
    ldrsh.w r7, [r14, #1074]
    ldrsh.w r9, [r14, #210]
    ldrsh.w r10, [r14, #1506]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #204]
    str.w r5, [r0, #1068]
    str.w r6, [r0, #1932]
    str.w r7, [r0, #2796]
    str.w r8, [r1, #204]
    str.w r9, [r1, #1068]
    str.w r10, [r1, #1932]
    str.w r11, [r1, #2796]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #914]
    ldrsh.w r7, [r14, #50]
    ldrsh.w r8, [r14, #1346]
    ldrsh.w r10, [r14, #482]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #208]
    str.w r5, [r0, #1072]
    str.w r6, [r0, #1936]
    str.w r7, [r0, #2800]
    str.w r8, [r1, #208]
    str.w r9, [r1, #1072]
    str.w r10, [r1, #1936]
    str.w r11, [r1, #2800]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1186]
    ldrsh.w r8, [r14, #322]
    ldrsh.w r9, [r14, #1618]
    ldrsh.w r11, [r14, #754]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #212]
    str.w r5, [r0, #1076]
    str.w r6, [r0, #1940]
    str.w r7, [r0, #2804]
    str.w r8, [r1, #212]
    str.w r9, [r1, #1076]
    str.w r10, [r1, #1940]
    str.w r11, [r1, #2804]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1188]
    ldrsh.w r8, [r14, #324]
    ldrsh.w r9, [r14, #1620]
    ldrsh.w r11, [r14, #756]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #216]
    str.w r5, [r0, #1080]
    str.w r6, [r0, #1944]
    str.w r7, [r0, #2808]
    str.w r8, [r1, #216]
    str.w r9, [r1, #1080]
    str.w r10, [r1, #1944]
    str.w r11, [r1, #2808]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1028]
    ldrsh.w r6, [r14, #164]
    ldrsh.w r7, [r14, #1460]
    ldrsh.w r9, [r14, #596]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #220]
    str.w r5, [r0, #1084]
    str.w r6, [r0, #1948]
    str.w r7, [r0, #2812]
    str.w r8, [r1, #220]
    str.w r9, [r1, #1084]
    str.w r10, [r1, #1948]
    str.w r11, [r1, #2812]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #4]
    ldrsh.w r5, [r14, #1300]
    ldrsh.w r7, [r14, #436]
    ldrsh.w r10, [r14, #868]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #224]
    str.w r5, [r0, #1088]
    str.w r6, [r0, #1952]
    str.w r7, [r0, #2816]
    str.w r8, [r1, #224]
    str.w r9, [r1, #1088]
    str.w r10, [r1, #1952]
    str.w r11, [r1, #2816]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #276]
    ldrsh.w r6, [r14, #1572]
    ldrsh.w r8, [r14, #708]
    ldrsh.w r11, [r14, #1140]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #228]
    str.w r5, [r0, #1092]
    str.w r6, [r0, #1956]
    str.w r7, [r0, #2820]
    str.w r8, [r1, #228]
    str.w r9, [r1, #1092]
    str.w r10, [r1, #1956]
    str.w r11, [r1, #2820]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1412]
    ldrsh.w r6, [r14, #548]
    ldrsh.w r9, [r14, #980]
    ldrsh.w r11, [r14, #116]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #232]
    str.w r5, [r0, #1096]
    str.w r6, [r0, #1960]
    str.w r7, [r0, #2824]
    str.w r8, [r1, #232]
    str.w r9, [r1, #1096]
    str.w r10, [r1, #1960]
    str.w r11, [r1, #2824]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #388]
    ldrsh.w r5, [r14, #1684]
    ldrsh.w r7, [r14, #820]
    ldrsh.w r10, [r14, #1252]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #236]
    str.w r5, [r0, #1100]
    str.w r6, [r0, #1964]
    str.w r7, [r0, #2828]
    str.w r8, [r1, #236]
    str.w r9, [r1, #1100]
    str.w r10, [r1, #1964]
    str.w r11, [r1, #2828]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #660]
    ldrsh.w r8, [r14, #1092]
    ldrsh.w r10, [r14, #228]
    ldrsh.w r11, [r14, #1524]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #240]
    str.w r5, [r0, #1104]
    str.w r6, [r0, #1968]
    str.w r7, [r0, #2832]
    str.w r8, [r1, #240]
    str.w r9, [r1, #1104]
    str.w r10, [r1, #1968]
    str.w r11, [r1, #2832]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #932]
    ldrsh.w r8, [r14, #68]
    ldrsh.w r9, [r14, #1364]
    ldrsh.w r11, [r14, #500]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #244]
    str.w r5, [r0, #1108]
    str.w r6, [r0, #1972]
    str.w r7, [r0, #2836]
    str.w r8, [r1, #244]
    str.w r9, [r1, #1108]
    str.w r10, [r1, #1972]
    str.w r11, [r1, #2836]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #772]
    ldrsh.w r7, [r14, #1204]
    ldrsh.w r9, [r14, #340]
    ldrsh.w r10, [r14, #1636]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #248]
    str.w r5, [r0, #1112]
    str.w r6, [r0, #1976]
    str.w r7, [r0, #2840]
    str.w r8, [r1, #248]
    str.w r9, [r1, #1112]
    str.w r10, [r1, #1976]
    str.w r11, [r1, #2840]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1044]
    ldrsh.w r7, [r14, #180]
    ldrsh.w r8, [r14, #1476]
    ldrsh.w r10, [r14, #612]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #252]
    str.w r5, [r0, #1116]
    str.w r6, [r0, #1980]
    str.w r7, [r0, #2844]
    str.w r8, [r1, #252]
    str.w r9, [r1, #1116]
    str.w r10, [r1, #1980]
    str.w r11, [r1, #2844]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #20]
    ldrsh.w r6, [r14, #1316]
    ldrsh.w r8, [r14, #452]
    ldrsh.w r11, [r14, #884]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #256]
    str.w r5, [r0, #1120]
    str.w r6, [r0, #1984]
    str.w r7, [r0, #2848]
    str.w r8, [r1, #256]
    str.w r9, [r1, #1120]
    str.w r10, [r1, #1984]
    str.w r11, [r1, #2848]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1156]
    ldrsh.w r6, [r14, #292]
    ldrsh.w r7, [r14, #1588]
    ldrsh.w r9, [r14, #724]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #260]
    str.w r5, [r0, #1124]
    str.w r6, [r0, #1988]
    str.w r7, [r0, #2852]
    str.w r8, [r1, #260]
    str.w r9, [r1, #1124]
    str.w r10, [r1, #1988]
    str.w r11, [r1, #2852]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #132]
    ldrsh.w r5, [r14, #1428]
    ldrsh.w r7, [r14, #564]
    ldrsh.w r10, [r14, #996]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #264]
    str.w r5, [r0, #1128]
    str.w r6, [r0, #1992]
    str.w r7, [r0, #2856]
    str.w r8, [r1, #264]
    str.w r9, [r1, #1128]
    str.w r10, [r1, #1992]
    str.w r11, [r1, #2856]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #404]
    ldrsh.w r6, [r14, #1700]
    ldrsh.w r8, [r14, #836]
    ldrsh.w r11, [r14, #1268]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #268]
    str.w r5, [r0, #1132]
    str.w r6, [r0, #1996]
    str.w r7, [r0, #2860]
    str.w r8, [r1, #268]
    str.w r9, [r1, #1132]
    str.w r10, [r1, #1996]
    str.w r11, [r1, #2860]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1540]
    ldrsh.w r6, [r14, #676]
    ldrsh.w r9, [r14, #1108]
    ldrsh.w r11, [r14, #244]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #272]
    str.w r5, [r0, #1136]
    str.w r6, [r0, #2000]
    str.w r7, [r0, #2864]
    str.w r8, [r1, #272]
    str.w r9, [r1, #1136]
    str.w r10, [r1, #2000]
    str.w r11, [r1, #2864]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #516]
    ldrsh.w r7, [r14, #948]
    ldrsh.w r9, [r14, #84]
    ldrsh.w r10, [r14, #1380]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #276]
    str.w r5, [r0, #1140]
    str.w r6, [r0, #2004]
    str.w r7, [r0, #2868]
    str.w r8, [r1, #276]
    str.w r9, [r1, #1140]
    str.w r10, [r1, #2004]
    str.w r11, [r1, #2868]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #788]
    ldrsh.w r8, [r14, #1220]
    ldrsh.w r10, [r14, #356]
    ldrsh.w r11, [r14, #1652]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #280]
    str.w r5, [r0, #1144]
    str.w r6, [r0, #2008]
    str.w r7, [r0, #2872]
    str.w r8, [r1, #280]
    str.w r9, [r1, #1144]
    str.w r10, [r1, #2008]
    str.w r11, [r1, #2872]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1060]
    ldrsh.w r8, [r14, #196]
    ldrsh.w r9, [r14, #1492]
    ldrsh.w r11, [r14, #628]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #284]
    str.w r5, [r0, #1148]
    str.w r6, [r0, #2012]
    str.w r7, [r0, #2876]
    str.w r8, [r1, #284]
    str.w r9, [r1, #1148]
    str.w r10, [r1, #2012]
    str.w r11, [r1, #2876]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #900]
    ldrsh.w r6, [r14, #36]
    ldrsh.w r7, [r14, #1332]
    ldrsh.w r9, [r14, #468]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #288]
    str.w r5, [r0, #1152]
    str.w r6, [r0, #2016]
    str.w r7, [r0, #2880]
    str.w r8, [r1, #288]
    str.w r9, [r1, #1152]
    str.w r10, [r1, #2016]
    str.w r11, [r1, #2880]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1172]
    ldrsh.w r7, [r14, #308]
    ldrsh.w r8, [r14, #1604]
    ldrsh.w r10, [r14, #740]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #292]
    str.w r5, [r0, #1156]
    str.w r6, [r0, #2020]
    str.w r7, [r0, #2884]
    str.w r8, [r1, #292]
    str.w r9, [r1, #1156]
    str.w r10, [r1, #2020]
    str.w r11, [r1, #2884]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #148]
    ldrsh.w r6, [r14, #1444]
    ldrsh.w r8, [r14, #580]
    ldrsh.w r11, [r14, #1012]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #296]
    str.w r5, [r0, #1160]
    str.w r6, [r0, #2024]
    str.w r7, [r0, #2888]
    str.w r8, [r1, #296]
    str.w r9, [r1, #1160]
    str.w r10, [r1, #2024]
    str.w r11, [r1, #2888]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1284]
    ldrsh.w r6, [r14, #420]
    ldrsh.w r9, [r14, #852]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #300]
    str.w r5, [r0, #1164]
    str.w r6, [r0, #2028]
    str.w r7, [r0, #2892]
    str.w r8, [r1, #300]
    str.w r9, [r1, #1164]
    str.w r10, [r1, #2028]
    str.w r11, [r1, #2892]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #260]
    ldrsh.w r5, [r14, #1556]
    ldrsh.w r7, [r14, #692]
    ldrsh.w r10, [r14, #1124]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #304]
    str.w r5, [r0, #1168]
    str.w r6, [r0, #2032]
    str.w r7, [r0, #2896]
    str.w r8, [r1, #304]
    str.w r9, [r1, #1168]
    str.w r10, [r1, #2032]
    str.w r11, [r1, #2896]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #532]
    ldrsh.w r8, [r14, #964]
    ldrsh.w r10, [r14, #100]
    ldrsh.w r11, [r14, #1396]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #308]
    str.w r5, [r0, #1172]
    str.w r6, [r0, #2036]
    str.w r7, [r0, #2900]
    str.w r8, [r1, #308]
    str.w r9, [r1, #1172]
    str.w r10, [r1, #2036]
    str.w r11, [r1, #2900]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1668]
    ldrsh.w r6, [r14, #804]
    ldrsh.w r9, [r14, #1236]
    ldrsh.w r11, [r14, #372]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #312]
    str.w r5, [r0, #1176]
    str.w r6, [r0, #2040]
    str.w r7, [r0, #2904]
    str.w r8, [r1, #312]
    str.w r9, [r1, #1176]
    str.w r10, [r1, #2040]
    str.w r11, [r1, #2904]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #644]
    ldrsh.w r7, [r14, #1076]
    ldrsh.w r9, [r14, #212]
    ldrsh.w r10, [r14, #1508]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #316]
    str.w r5, [r0, #1180]
    str.w r6, [r0, #2044]
    str.w r7, [r0, #2908]
    str.w r8, [r1, #316]
    str.w r9, [r1, #1180]
    str.w r10, [r1, #2044]
    str.w r11, [r1, #2908]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #916]
    ldrsh.w r7, [r14, #52]
    ldrsh.w r8, [r14, #1348]
    ldrsh.w r10, [r14, #484]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #320]
    str.w r5, [r0, #1184]
    str.w r6, [r0, #2048]
    str.w r7, [r0, #2912]
    str.w r8, [r1, #320]
    str.w r9, [r1, #1184]
    str.w r10, [r1, #2048]
    str.w r11, [r1, #2912]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #918]
    ldrsh.w r7, [r14, #54]
    ldrsh.w r8, [r14, #1350]
    ldrsh.w r10, [r14, #486]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #324]
    str.w r5, [r0, #1188]
    str.w r6, [r0, #2052]
    str.w r7, [r0, #2916]
    str.w r8, [r1, #324]
    str.w r9, [r1, #1188]
    str.w r10, [r1, #2052]
    str.w r11, [r1, #2916]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1190]
    ldrsh.w r8, [r14, #326]
    ldrsh.w r9, [r14, #1622]
    ldrsh.w r11, [r14, #758]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #328]
    str.w r5, [r0, #1192]
    str.w r6, [r0, #2056]
    str.w r7, [r0, #2920]
    str.w r8, [r1, #328]
    str.w r9, [r1, #1192]
    str.w r10, [r1, #2056]
    str.w r11, [r1, #2920]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1030]
    ldrsh.w r6, [r14, #166]
    ldrsh.w r7, [r14, #1462]
    ldrsh.w r9, [r14, #598]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #332]
    str.w r5, [r0, #1196]
    str.w r6, [r0, #2060]
    str.w r7, [r0, #2924]
    str.w r8, [r1, #332]
    str.w r9, [r1, #1196]
    str.w r10, [r1, #2060]
    str.w r11, [r1, #2924]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #6]
    ldrsh.w r5, [r14, #1302]
    ldrsh.w r7, [r14, #438]
    ldrsh.w r10, [r14, #870]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #336]
    str.w r5, [r0, #1200]
    str.w r6, [r0, #2064]
    str.w r7, [r0, #2928]
    str.w r8, [r1, #336]
    str.w r9, [r1, #1200]
    str.w r10, [r1, #2064]
    str.w r11, [r1, #2928]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #278]
    ldrsh.w r6, [r14, #1574]
    ldrsh.w r8, [r14, #710]
    ldrsh.w r11, [r14, #1142]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #340]
    str.w r5, [r0, #1204]
    str.w r6, [r0, #2068]
    str.w r7, [r0, #2932]
    str.w r8, [r1, #340]
    str.w r9, [r1, #1204]
    str.w r10, [r1, #2068]
    str.w r11, [r1, #2932]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1414]
    ldrsh.w r6, [r14, #550]
    ldrsh.w r9, [r14, #982]
    ldrsh.w r11, [r14, #118]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #344]
    str.w r5, [r0, #1208]
    str.w r6, [r0, #2072]
    str.w r7, [r0, #2936]
    str.w r8, [r1, #344]
    str.w r9, [r1, #1208]
    str.w r10, [r1, #2072]
    str.w r11, [r1, #2936]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #390]
    ldrsh.w r5, [r14, #1686]
    ldrsh.w r7, [r14, #822]
    ldrsh.w r10, [r14, #1254]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #348]
    str.w r5, [r0, #1212]
    str.w r6, [r0, #2076]
    str.w r7, [r0, #2940]
    str.w r8, [r1, #348]
    str.w r9, [r1, #1212]
    str.w r10, [r1, #2076]
    str.w r11, [r1, #2940]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #662]
    ldrsh.w r8, [r14, #1094]
    ldrsh.w r10, [r14, #230]
    ldrsh.w r11, [r14, #1526]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #352]
    str.w r5, [r0, #1216]
    str.w r6, [r0, #2080]
    str.w r7, [r0, #2944]
    str.w r8, [r1, #352]
    str.w r9, [r1, #1216]
    str.w r10, [r1, #2080]
    str.w r11, [r1, #2944]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #934]
    ldrsh.w r8, [r14, #70]
    ldrsh.w r9, [r14, #1366]
    ldrsh.w r11, [r14, #502]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #356]
    str.w r5, [r0, #1220]
    str.w r6, [r0, #2084]
    str.w r7, [r0, #2948]
    str.w r8, [r1, #356]
    str.w r9, [r1, #1220]
    str.w r10, [r1, #2084]
    str.w r11, [r1, #2948]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #774]
    ldrsh.w r7, [r14, #1206]
    ldrsh.w r9, [r14, #342]
    ldrsh.w r10, [r14, #1638]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #360]
    str.w r5, [r0, #1224]
    str.w r6, [r0, #2088]
    str.w r7, [r0, #2952]
    str.w r8, [r1, #360]
    str.w r9, [r1, #1224]
    str.w r10, [r1, #2088]
    str.w r11, [r1, #2952]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1046]
    ldrsh.w r7, [r14, #182]
    ldrsh.w r8, [r14, #1478]
    ldrsh.w r10, [r14, #614]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #364]
    str.w r5, [r0, #1228]
    str.w r6, [r0, #2092]
    str.w r7, [r0, #2956]
    str.w r8, [r1, #364]
    str.w r9, [r1, #1228]
    str.w r10, [r1, #2092]
    str.w r11, [r1, #2956]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #22]
    ldrsh.w r6, [r14, #1318]
    ldrsh.w r8, [r14, #454]
    ldrsh.w r11, [r14, #886]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #368]
    str.w r5, [r0, #1232]
    str.w r6, [r0, #2096]
    str.w r7, [r0, #2960]
    str.w r8, [r1, #368]
    str.w r9, [r1, #1232]
    str.w r10, [r1, #2096]
    str.w r11, [r1, #2960]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1158]
    ldrsh.w r6, [r14, #294]
    ldrsh.w r7, [r14, #1590]
    ldrsh.w r9, [r14, #726]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #372]
    str.w r5, [r0, #1236]
    str.w r6, [r0, #2100]
    str.w r7, [r0, #2964]
    str.w r8, [r1, #372]
    str.w r9, [r1, #1236]
    str.w r10, [r1, #2100]
    str.w r11, [r1, #2964]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #134]
    ldrsh.w r5, [r14, #1430]
    ldrsh.w r7, [r14, #566]
    ldrsh.w r10, [r14, #998]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #376]
    str.w r5, [r0, #1240]
    str.w r6, [r0, #2104]
    str.w r7, [r0, #2968]
    str.w r8, [r1, #376]
    str.w r9, [r1, #1240]
    str.w r10, [r1, #2104]
    str.w r11, [r1, #2968]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #406]
    ldrsh.w r6, [r14, #1702]
    ldrsh.w r8, [r14, #838]
    ldrsh.w r11, [r14, #1270]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #380]
    str.w r5, [r0, #1244]
    str.w r6, [r0, #2108]
    str.w r7, [r0, #2972]
    str.w r8, [r1, #380]
    str.w r9, [r1, #1244]
    str.w r10, [r1, #2108]
    str.w r11, [r1, #2972]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1542]
    ldrsh.w r6, [r14, #678]
    ldrsh.w r9, [r14, #1110]
    ldrsh.w r11, [r14, #246]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #384]
    str.w r5, [r0, #1248]
    str.w r6, [r0, #2112]
    str.w r7, [r0, #2976]
    str.w r8, [r1, #384]
    str.w r9, [r1, #1248]
    str.w r10, [r1, #2112]
    str.w r11, [r1, #2976]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #518]
    ldrsh.w r7, [r14, #950]
    ldrsh.w r9, [r14, #86]
    ldrsh.w r10, [r14, #1382]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #388]
    str.w r5, [r0, #1252]
    str.w r6, [r0, #2116]
    str.w r7, [r0, #2980]
    str.w r8, [r1, #388]
    str.w r9, [r1, #1252]
    str.w r10, [r1, #2116]
    str.w r11, [r1, #2980]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #790]
    ldrsh.w r8, [r14, #1222]
    ldrsh.w r10, [r14, #358]
    ldrsh.w r11, [r14, #1654]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #392]
    str.w r5, [r0, #1256]
    str.w r6, [r0, #2120]
    str.w r7, [r0, #2984]
    str.w r8, [r1, #392]
    str.w r9, [r1, #1256]
    str.w r10, [r1, #2120]
    str.w r11, [r1, #2984]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1062]
    ldrsh.w r8, [r14, #198]
    ldrsh.w r9, [r14, #1494]
    ldrsh.w r11, [r14, #630]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #396]
    str.w r5, [r0, #1260]
    str.w r6, [r0, #2124]
    str.w r7, [r0, #2988]
    str.w r8, [r1, #396]
    str.w r9, [r1, #1260]
    str.w r10, [r1, #2124]
    str.w r11, [r1, #2988]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #902]
    ldrsh.w r6, [r14, #38]
    ldrsh.w r7, [r14, #1334]
    ldrsh.w r9, [r14, #470]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #400]
    str.w r5, [r0, #1264]
    str.w r6, [r0, #2128]
    str.w r7, [r0, #2992]
    str.w r8, [r1, #400]
    str.w r9, [r1, #1264]
    str.w r10, [r1, #2128]
    str.w r11, [r1, #2992]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1174]
    ldrsh.w r7, [r14, #310]
    ldrsh.w r8, [r14, #1606]
    ldrsh.w r10, [r14, #742]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #404]
    str.w r5, [r0, #1268]
    str.w r6, [r0, #2132]
    str.w r7, [r0, #2996]
    str.w r8, [r1, #404]
    str.w r9, [r1, #1268]
    str.w r10, [r1, #2132]
    str.w r11, [r1, #2996]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #150]
    ldrsh.w r6, [r14, #1446]
    ldrsh.w r8, [r14, #582]
    ldrsh.w r11, [r14, #1014]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #408]
    str.w r5, [r0, #1272]
    str.w r6, [r0, #2136]
    str.w r7, [r0, #3000]
    str.w r8, [r1, #408]
    str.w r9, [r1, #1272]
    str.w r10, [r1, #2136]
    str.w r11, [r1, #3000]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1286]
    ldrsh.w r6, [r14, #422]
    ldrsh.w r9, [r14, #854]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #412]
    str.w r5, [r0, #1276]
    str.w r6, [r0, #2140]
    str.w r7, [r0, #3004]
    str.w r8, [r1, #412]
    str.w r9, [r1, #1276]
    str.w r10, [r1, #2140]
    str.w r11, [r1, #3004]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #262]
    ldrsh.w r5, [r14, #1558]
    ldrsh.w r7, [r14, #694]
    ldrsh.w r10, [r14, #1126]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #416]
    str.w r5, [r0, #1280]
    str.w r6, [r0, #2144]
    str.w r7, [r0, #3008]
    str.w r8, [r1, #416]
    str.w r9, [r1, #1280]
    str.w r10, [r1, #2144]
    str.w r11, [r1, #3008]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #534]
    ldrsh.w r8, [r14, #966]
    ldrsh.w r10, [r14, #102]
    ldrsh.w r11, [r14, #1398]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #420]
    str.w r5, [r0, #1284]
    str.w r6, [r0, #2148]
    str.w r7, [r0, #3012]
    str.w r8, [r1, #420]
    str.w r9, [r1, #1284]
    str.w r10, [r1, #2148]
    str.w r11, [r1, #3012]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1670]
    ldrsh.w r6, [r14, #806]
    ldrsh.w r9, [r14, #1238]
    ldrsh.w r11, [r14, #374]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #424]
    str.w r5, [r0, #1288]
    str.w r6, [r0, #2152]
    str.w r7, [r0, #3016]
    str.w r8, [r1, #424]
    str.w r9, [r1, #1288]
    str.w r10, [r1, #2152]
    str.w r11, [r1, #3016]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #646]
    ldrsh.w r7, [r14, #1078]
    ldrsh.w r9, [r14, #214]
    ldrsh.w r10, [r14, #1510]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #428]
    str.w r5, [r0, #1292]
    str.w r6, [r0, #2156]
    str.w r7, [r0, #3020]
    str.w r8, [r1, #428]
    str.w r9, [r1, #1292]
    str.w r10, [r1, #2156]
    str.w r11, [r1, #3020]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #648]
    ldrsh.w r7, [r14, #1080]
    ldrsh.w r9, [r14, #216]
    ldrsh.w r10, [r14, #1512]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #432]
    str.w r5, [r0, #1296]
    str.w r6, [r0, #2160]
    str.w r7, [r0, #3024]
    str.w r8, [r1, #432]
    str.w r9, [r1, #1296]
    str.w r10, [r1, #2160]
    str.w r11, [r1, #3024]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #920]
    ldrsh.w r7, [r14, #56]
    ldrsh.w r8, [r14, #1352]
    ldrsh.w r10, [r14, #488]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #436]
    str.w r5, [r0, #1300]
    str.w r6, [r0, #2164]
    str.w r7, [r0, #3028]
    str.w r8, [r1, #436]
    str.w r9, [r1, #1300]
    str.w r10, [r1, #2164]
    str.w r11, [r1, #3028]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1192]
    ldrsh.w r8, [r14, #328]
    ldrsh.w r9, [r14, #1624]
    ldrsh.w r11, [r14, #760]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #440]
    str.w r5, [r0, #1304]
    str.w r6, [r0, #2168]
    str.w r7, [r0, #3032]
    str.w r8, [r1, #440]
    str.w r9, [r1, #1304]
    str.w r10, [r1, #2168]
    str.w r11, [r1, #3032]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1032]
    ldrsh.w r6, [r14, #168]
    ldrsh.w r7, [r14, #1464]
    ldrsh.w r9, [r14, #600]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #444]
    str.w r5, [r0, #1308]
    str.w r6, [r0, #2172]
    str.w r7, [r0, #3036]
    str.w r8, [r1, #444]
    str.w r9, [r1, #1308]
    str.w r10, [r1, #2172]
    str.w r11, [r1, #3036]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #8]
    ldrsh.w r5, [r14, #1304]
    ldrsh.w r7, [r14, #440]
    ldrsh.w r10, [r14, #872]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #448]
    str.w r5, [r0, #1312]
    str.w r6, [r0, #2176]
    str.w r7, [r0, #3040]
    str.w r8, [r1, #448]
    str.w r9, [r1, #1312]
    str.w r10, [r1, #2176]
    str.w r11, [r1, #3040]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #280]
    ldrsh.w r6, [r14, #1576]
    ldrsh.w r8, [r14, #712]
    ldrsh.w r11, [r14, #1144]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #452]
    str.w r5, [r0, #1316]
    str.w r6, [r0, #2180]
    str.w r7, [r0, #3044]
    str.w r8, [r1, #452]
    str.w r9, [r1, #1316]
    str.w r10, [r1, #2180]
    str.w r11, [r1, #3044]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1416]
    ldrsh.w r6, [r14, #552]
    ldrsh.w r9, [r14, #984]
    ldrsh.w r11, [r14, #120]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #456]
    str.w r5, [r0, #1320]
    str.w r6, [r0, #2184]
    str.w r7, [r0, #3048]
    str.w r8, [r1, #456]
    str.w r9, [r1, #1320]
    str.w r10, [r1, #2184]
    str.w r11, [r1, #3048]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #392]
    ldrsh.w r5, [r14, #1688]
    ldrsh.w r7, [r14, #824]
    ldrsh.w r10, [r14, #1256]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #460]
    str.w r5, [r0, #1324]
    str.w r6, [r0, #2188]
    str.w r7, [r0, #3052]
    str.w r8, [r1, #460]
    str.w r9, [r1, #1324]
    str.w r10, [r1, #2188]
    str.w r11, [r1, #3052]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #664]
    ldrsh.w r8, [r14, #1096]
    ldrsh.w r10, [r14, #232]
    ldrsh.w r11, [r14, #1528]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #464]
    str.w r5, [r0, #1328]
    str.w r6, [r0, #2192]
    str.w r7, [r0, #3056]
    str.w r8, [r1, #464]
    str.w r9, [r1, #1328]
    str.w r10, [r1, #2192]
    str.w r11, [r1, #3056]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #936]
    ldrsh.w r8, [r14, #72]
    ldrsh.w r9, [r14, #1368]
    ldrsh.w r11, [r14, #504]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #468]
    str.w r5, [r0, #1332]
    str.w r6, [r0, #2196]
    str.w r7, [r0, #3060]
    str.w r8, [r1, #468]
    str.w r9, [r1, #1332]
    str.w r10, [r1, #2196]
    str.w r11, [r1, #3060]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #776]
    ldrsh.w r7, [r14, #1208]
    ldrsh.w r9, [r14, #344]
    ldrsh.w r10, [r14, #1640]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #472]
    str.w r5, [r0, #1336]
    str.w r6, [r0, #2200]
    str.w r7, [r0, #3064]
    str.w r8, [r1, #472]
    str.w r9, [r1, #1336]
    str.w r10, [r1, #2200]
    str.w r11, [r1, #3064]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1048]
    ldrsh.w r7, [r14, #184]
    ldrsh.w r8, [r14, #1480]
    ldrsh.w r10, [r14, #616]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #476]
    str.w r5, [r0, #1340]
    str.w r6, [r0, #2204]
    str.w r7, [r0, #3068]
    str.w r8, [r1, #476]
    str.w r9, [r1, #1340]
    str.w r10, [r1, #2204]
    str.w r11, [r1, #3068]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #24]
    ldrsh.w r6, [r14, #1320]
    ldrsh.w r8, [r14, #456]
    ldrsh.w r11, [r14, #888]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #480]
    str.w r5, [r0, #1344]
    str.w r6, [r0, #2208]
    str.w r7, [r0, #3072]
    str.w r8, [r1, #480]
    str.w r9, [r1, #1344]
    str.w r10, [r1, #2208]
    str.w r11, [r1, #3072]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1160]
    ldrsh.w r6, [r14, #296]
    ldrsh.w r7, [r14, #1592]
    ldrsh.w r9, [r14, #728]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #484]
    str.w r5, [r0, #1348]
    str.w r6, [r0, #2212]
    str.w r7, [r0, #3076]
    str.w r8, [r1, #484]
    str.w r9, [r1, #1348]
    str.w r10, [r1, #2212]
    str.w r11, [r1, #3076]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #136]
    ldrsh.w r5, [r14, #1432]
    ldrsh.w r7, [r14, #568]
    ldrsh.w r10, [r14, #1000]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #488]
    str.w r5, [r0, #1352]
    str.w r6, [r0, #2216]
    str.w r7, [r0, #3080]
    str.w r8, [r1, #488]
    str.w r9, [r1, #1352]
    str.w r10, [r1, #2216]
    str.w r11, [r1, #3080]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #408]
    ldrsh.w r6, [r14, #1704]
    ldrsh.w r8, [r14, #840]
    ldrsh.w r11, [r14, #1272]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #492]
    str.w r5, [r0, #1356]
    str.w r6, [r0, #2220]
    str.w r7, [r0, #3084]
    str.w r8, [r1, #492]
    str.w r9, [r1, #1356]
    str.w r10, [r1, #2220]
    str.w r11, [r1, #3084]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1544]
    ldrsh.w r6, [r14, #680]
    ldrsh.w r9, [r14, #1112]
    ldrsh.w r11, [r14, #248]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #496]
    str.w r5, [r0, #1360]
    str.w r6, [r0, #2224]
    str.w r7, [r0, #3088]
    str.w r8, [r1, #496]
    str.w r9, [r1, #1360]
    str.w r10, [r1, #2224]
    str.w r11, [r1, #3088]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #520]
    ldrsh.w r7, [r14, #952]
    ldrsh.w r9, [r14, #88]
    ldrsh.w r10, [r14, #1384]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #500]
    str.w r5, [r0, #1364]
    str.w r6, [r0, #2228]
    str.w r7, [r0, #3092]
    str.w r8, [r1, #500]
    str.w r9, [r1, #1364]
    str.w r10, [r1, #2228]
    str.w r11, [r1, #3092]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #792]
    ldrsh.w r8, [r14, #1224]
    ldrsh.w r10, [r14, #360]
    ldrsh.w r11, [r14, #1656]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #504]
    str.w r5, [r0, #1368]
    str.w r6, [r0, #2232]
    str.w r7, [r0, #3096]
    str.w r8, [r1, #504]
    str.w r9, [r1, #1368]
    str.w r10, [r1, #2232]
    str.w r11, [r1, #3096]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1064]
    ldrsh.w r8, [r14, #200]
    ldrsh.w r9, [r14, #1496]
    ldrsh.w r11, [r14, #632]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #508]
    str.w r5, [r0, #1372]
    str.w r6, [r0, #2236]
    str.w r7, [r0, #3100]
    str.w r8, [r1, #508]
    str.w r9, [r1, #1372]
    str.w r10, [r1, #2236]
    str.w r11, [r1, #3100]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #904]
    ldrsh.w r6, [r14, #40]
    ldrsh.w r7, [r14, #1336]
    ldrsh.w r9, [r14, #472]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #512]
    str.w r5, [r0, #1376]
    str.w r6, [r0, #2240]
    str.w r7, [r0, #3104]
    str.w r8, [r1, #512]
    str.w r9, [r1, #1376]
    str.w r10, [r1, #2240]
    str.w r11, [r1, #3104]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1176]
    ldrsh.w r7, [r14, #312]
    ldrsh.w r8, [r14, #1608]
    ldrsh.w r10, [r14, #744]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #516]
    str.w r5, [r0, #1380]
    str.w r6, [r0, #2244]
    str.w r7, [r0, #3108]
    str.w r8, [r1, #516]
    str.w r9, [r1, #1380]
    str.w r10, [r1, #2244]
    str.w r11, [r1, #3108]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #152]
    ldrsh.w r6, [r14, #1448]
    ldrsh.w r8, [r14, #584]
    ldrsh.w r11, [r14, #1016]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #520]
    str.w r5, [r0, #1384]
    str.w r6, [r0, #2248]
    str.w r7, [r0, #3112]
    str.w r8, [r1, #520]
    str.w r9, [r1, #1384]
    str.w r10, [r1, #2248]
    str.w r11, [r1, #3112]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1288]
    ldrsh.w r6, [r14, #424]
    ldrsh.w r9, [r14, #856]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #524]
    str.w r5, [r0, #1388]
    str.w r6, [r0, #2252]
    str.w r7, [r0, #3116]
    str.w r8, [r1, #524]
    str.w r9, [r1, #1388]
    str.w r10, [r1, #2252]
    str.w r11, [r1, #3116]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #264]
    ldrsh.w r5, [r14, #1560]
    ldrsh.w r7, [r14, #696]
    ldrsh.w r10, [r14, #1128]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #528]
    str.w r5, [r0, #1392]
    str.w r6, [r0, #2256]
    str.w r7, [r0, #3120]
    str.w r8, [r1, #528]
    str.w r9, [r1, #1392]
    str.w r10, [r1, #2256]
    str.w r11, [r1, #3120]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #536]
    ldrsh.w r8, [r14, #968]
    ldrsh.w r10, [r14, #104]
    ldrsh.w r11, [r14, #1400]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #532]
    str.w r5, [r0, #1396]
    str.w r6, [r0, #2260]
    str.w r7, [r0, #3124]
    str.w r8, [r1, #532]
    str.w r9, [r1, #1396]
    str.w r10, [r1, #2260]
    str.w r11, [r1, #3124]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1672]
    ldrsh.w r6, [r14, #808]
    ldrsh.w r9, [r14, #1240]
    ldrsh.w r11, [r14, #376]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #536]
    str.w r5, [r0, #1400]
    str.w r6, [r0, #2264]
    str.w r7, [r0, #3128]
    str.w r8, [r1, #536]
    str.w r9, [r1, #1400]
    str.w r10, [r1, #2264]
    str.w r11, [r1, #3128]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1674]
    ldrsh.w r6, [r14, #810]
    ldrsh.w r9, [r14, #1242]
    ldrsh.w r11, [r14, #378]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #540]
    str.w r5, [r0, #1404]
    str.w r6, [r0, #2268]
    str.w r7, [r0, #3132]
    str.w r8, [r1, #540]
    str.w r9, [r1, #1404]
    str.w r10, [r1, #2268]
    str.w r11, [r1, #3132]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #650]
    ldrsh.w r7, [r14, #1082]
    ldrsh.w r9, [r14, #218]
    ldrsh.w r10, [r14, #1514]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #544]
    str.w r5, [r0, #1408]
    str.w r6, [r0, #2272]
    str.w r7, [r0, #3136]
    str.w r8, [r1, #544]
    str.w r9, [r1, #1408]
    str.w r10, [r1, #2272]
    str.w r11, [r1, #3136]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #922]
    ldrsh.w r7, [r14, #58]
    ldrsh.w r8, [r14, #1354]
    ldrsh.w r10, [r14, #490]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #548]
    str.w r5, [r0, #1412]
    str.w r6, [r0, #2276]
    str.w r7, [r0, #3140]
    str.w r8, [r1, #548]
    str.w r9, [r1, #1412]
    str.w r10, [r1, #2276]
    str.w r11, [r1, #3140]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1194]
    ldrsh.w r8, [r14, #330]
    ldrsh.w r9, [r14, #1626]
    ldrsh.w r11, [r14, #762]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #552]
    str.w r5, [r0, #1416]
    str.w r6, [r0, #2280]
    str.w r7, [r0, #3144]
    str.w r8, [r1, #552]
    str.w r9, [r1, #1416]
    str.w r10, [r1, #2280]
    str.w r11, [r1, #3144]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1034]
    ldrsh.w r6, [r14, #170]
    ldrsh.w r7, [r14, #1466]
    ldrsh.w r9, [r14, #602]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #556]
    str.w r5, [r0, #1420]
    str.w r6, [r0, #2284]
    str.w r7, [r0, #3148]
    str.w r8, [r1, #556]
    str.w r9, [r1, #1420]
    str.w r10, [r1, #2284]
    str.w r11, [r1, #3148]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #10]
    ldrsh.w r5, [r14, #1306]
    ldrsh.w r7, [r14, #442]
    ldrsh.w r10, [r14, #874]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #560]
    str.w r5, [r0, #1424]
    str.w r6, [r0, #2288]
    str.w r7, [r0, #3152]
    str.w r8, [r1, #560]
    str.w r9, [r1, #1424]
    str.w r10, [r1, #2288]
    str.w r11, [r1, #3152]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #282]
    ldrsh.w r6, [r14, #1578]
    ldrsh.w r8, [r14, #714]
    ldrsh.w r11, [r14, #1146]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #564]
    str.w r5, [r0, #1428]
    str.w r6, [r0, #2292]
    str.w r7, [r0, #3156]
    str.w r8, [r1, #564]
    str.w r9, [r1, #1428]
    str.w r10, [r1, #2292]
    str.w r11, [r1, #3156]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1418]
    ldrsh.w r6, [r14, #554]
    ldrsh.w r9, [r14, #986]
    ldrsh.w r11, [r14, #122]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #568]
    str.w r5, [r0, #1432]
    str.w r6, [r0, #2296]
    str.w r7, [r0, #3160]
    str.w r8, [r1, #568]
    str.w r9, [r1, #1432]
    str.w r10, [r1, #2296]
    str.w r11, [r1, #3160]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #394]
    ldrsh.w r5, [r14, #1690]
    ldrsh.w r7, [r14, #826]
    ldrsh.w r10, [r14, #1258]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #572]
    str.w r5, [r0, #1436]
    str.w r6, [r0, #2300]
    str.w r7, [r0, #3164]
    str.w r8, [r1, #572]
    str.w r9, [r1, #1436]
    str.w r10, [r1, #2300]
    str.w r11, [r1, #3164]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #666]
    ldrsh.w r8, [r14, #1098]
    ldrsh.w r10, [r14, #234]
    ldrsh.w r11, [r14, #1530]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #576]
    str.w r5, [r0, #1440]
    str.w r6, [r0, #2304]
    str.w r7, [r0, #3168]
    str.w r8, [r1, #576]
    str.w r9, [r1, #1440]
    str.w r10, [r1, #2304]
    str.w r11, [r1, #3168]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #938]
    ldrsh.w r8, [r14, #74]
    ldrsh.w r9, [r14, #1370]
    ldrsh.w r11, [r14, #506]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #580]
    str.w r5, [r0, #1444]
    str.w r6, [r0, #2308]
    str.w r7, [r0, #3172]
    str.w r8, [r1, #580]
    str.w r9, [r1, #1444]
    str.w r10, [r1, #2308]
    str.w r11, [r1, #3172]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #778]
    ldrsh.w r7, [r14, #1210]
    ldrsh.w r9, [r14, #346]
    ldrsh.w r10, [r14, #1642]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #584]
    str.w r5, [r0, #1448]
    str.w r6, [r0, #2312]
    str.w r7, [r0, #3176]
    str.w r8, [r1, #584]
    str.w r9, [r1, #1448]
    str.w r10, [r1, #2312]
    str.w r11, [r1, #3176]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1050]
    ldrsh.w r7, [r14, #186]
    ldrsh.w r8, [r14, #1482]
    ldrsh.w r10, [r14, #618]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #588]
    str.w r5, [r0, #1452]
    str.w r6, [r0, #2316]
    str.w r7, [r0, #3180]
    str.w r8, [r1, #588]
    str.w r9, [r1, #1452]
    str.w r10, [r1, #2316]
    str.w r11, [r1, #3180]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #26]
    ldrsh.w r6, [r14, #1322]
    ldrsh.w r8, [r14, #458]
    ldrsh.w r11, [r14, #890]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #592]
    str.w r5, [r0, #1456]
    str.w r6, [r0, #2320]
    str.w r7, [r0, #3184]
    str.w r8, [r1, #592]
    str.w r9, [r1, #1456]
    str.w r10, [r1, #2320]
    str.w r11, [r1, #3184]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1162]
    ldrsh.w r6, [r14, #298]
    ldrsh.w r7, [r14, #1594]
    ldrsh.w r9, [r14, #730]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #596]
    str.w r5, [r0, #1460]
    str.w r6, [r0, #2324]
    str.w r7, [r0, #3188]
    str.w r8, [r1, #596]
    str.w r9, [r1, #1460]
    str.w r10, [r1, #2324]
    str.w r11, [r1, #3188]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #138]
    ldrsh.w r5, [r14, #1434]
    ldrsh.w r7, [r14, #570]
    ldrsh.w r10, [r14, #1002]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #600]
    str.w r5, [r0, #1464]
    str.w r6, [r0, #2328]
    str.w r7, [r0, #3192]
    str.w r8, [r1, #600]
    str.w r9, [r1, #1464]
    str.w r10, [r1, #2328]
    str.w r11, [r1, #3192]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #410]
    ldrsh.w r6, [r14, #1706]
    ldrsh.w r8, [r14, #842]
    ldrsh.w r11, [r14, #1274]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #604]
    str.w r5, [r0, #1468]
    str.w r6, [r0, #2332]
    str.w r7, [r0, #3196]
    str.w r8, [r1, #604]
    str.w r9, [r1, #1468]
    str.w r10, [r1, #2332]
    str.w r11, [r1, #3196]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1546]
    ldrsh.w r6, [r14, #682]
    ldrsh.w r9, [r14, #1114]
    ldrsh.w r11, [r14, #250]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #608]
    str.w r5, [r0, #1472]
    str.w r6, [r0, #2336]
    str.w r7, [r0, #3200]
    str.w r8, [r1, #608]
    str.w r9, [r1, #1472]
    str.w r10, [r1, #2336]
    str.w r11, [r1, #3200]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #522]
    ldrsh.w r7, [r14, #954]
    ldrsh.w r9, [r14, #90]
    ldrsh.w r10, [r14, #1386]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #612]
    str.w r5, [r0, #1476]
    str.w r6, [r0, #2340]
    str.w r7, [r0, #3204]
    str.w r8, [r1, #612]
    str.w r9, [r1, #1476]
    str.w r10, [r1, #2340]
    str.w r11, [r1, #3204]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #794]
    ldrsh.w r8, [r14, #1226]
    ldrsh.w r10, [r14, #362]
    ldrsh.w r11, [r14, #1658]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #616]
    str.w r5, [r0, #1480]
    str.w r6, [r0, #2344]
    str.w r7, [r0, #3208]
    str.w r8, [r1, #616]
    str.w r9, [r1, #1480]
    str.w r10, [r1, #2344]
    str.w r11, [r1, #3208]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1066]
    ldrsh.w r8, [r14, #202]
    ldrsh.w r9, [r14, #1498]
    ldrsh.w r11, [r14, #634]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #620]
    str.w r5, [r0, #1484]
    str.w r6, [r0, #2348]
    str.w r7, [r0, #3212]
    str.w r8, [r1, #620]
    str.w r9, [r1, #1484]
    str.w r10, [r1, #2348]
    str.w r11, [r1, #3212]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #906]
    ldrsh.w r6, [r14, #42]
    ldrsh.w r7, [r14, #1338]
    ldrsh.w r9, [r14, #474]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #624]
    str.w r5, [r0, #1488]
    str.w r6, [r0, #2352]
    str.w r7, [r0, #3216]
    str.w r8, [r1, #624]
    str.w r9, [r1, #1488]
    str.w r10, [r1, #2352]
    str.w r11, [r1, #3216]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1178]
    ldrsh.w r7, [r14, #314]
    ldrsh.w r8, [r14, #1610]
    ldrsh.w r10, [r14, #746]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #628]
    str.w r5, [r0, #1492]
    str.w r6, [r0, #2356]
    str.w r7, [r0, #3220]
    str.w r8, [r1, #628]
    str.w r9, [r1, #1492]
    str.w r10, [r1, #2356]
    str.w r11, [r1, #3220]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #154]
    ldrsh.w r6, [r14, #1450]
    ldrsh.w r8, [r14, #586]
    ldrsh.w r11, [r14, #1018]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #632]
    str.w r5, [r0, #1496]
    str.w r6, [r0, #2360]
    str.w r7, [r0, #3224]
    str.w r8, [r1, #632]
    str.w r9, [r1, #1496]
    str.w r10, [r1, #2360]
    str.w r11, [r1, #3224]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1290]
    ldrsh.w r6, [r14, #426]
    ldrsh.w r9, [r14, #858]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #636]
    str.w r5, [r0, #1500]
    str.w r6, [r0, #2364]
    str.w r7, [r0, #3228]
    str.w r8, [r1, #636]
    str.w r9, [r1, #1500]
    str.w r10, [r1, #2364]
    str.w r11, [r1, #3228]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #266]
    ldrsh.w r5, [r14, #1562]
    ldrsh.w r7, [r14, #698]
    ldrsh.w r10, [r14, #1130]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #640]
    str.w r5, [r0, #1504]
    str.w r6, [r0, #2368]
    str.w r7, [r0, #3232]
    str.w r8, [r1, #640]
    str.w r9, [r1, #1504]
    str.w r10, [r1, #2368]
    str.w r11, [r1, #3232]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #538]
    ldrsh.w r8, [r14, #970]
    ldrsh.w r10, [r14, #106]
    ldrsh.w r11, [r14, #1402]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #644]
    str.w r5, [r0, #1508]
    str.w r6, [r0, #2372]
    str.w r7, [r0, #3236]
    str.w r8, [r1, #644]
    str.w r9, [r1, #1508]
    str.w r10, [r1, #2372]
    str.w r11, [r1, #3236]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #540]
    ldrsh.w r8, [r14, #972]
    ldrsh.w r10, [r14, #108]
    ldrsh.w r11, [r14, #1404]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #648]
    str.w r5, [r0, #1512]
    str.w r6, [r0, #2376]
    str.w r7, [r0, #3240]
    str.w r8, [r1, #648]
    str.w r9, [r1, #1512]
    str.w r10, [r1, #2376]
    str.w r11, [r1, #3240]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1676]
    ldrsh.w r6, [r14, #812]
    ldrsh.w r9, [r14, #1244]
    ldrsh.w r11, [r14, #380]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #652]
    str.w r5, [r0, #1516]
    str.w r6, [r0, #2380]
    str.w r7, [r0, #3244]
    str.w r8, [r1, #652]
    str.w r9, [r1, #1516]
    str.w r10, [r1, #2380]
    str.w r11, [r1, #3244]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #652]
    ldrsh.w r7, [r14, #1084]
    ldrsh.w r9, [r14, #220]
    ldrsh.w r10, [r14, #1516]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #656]
    str.w r5, [r0, #1520]
    str.w r6, [r0, #2384]
    str.w r7, [r0, #3248]
    str.w r8, [r1, #656]
    str.w r9, [r1, #1520]
    str.w r10, [r1, #2384]
    str.w r11, [r1, #3248]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #924]
    ldrsh.w r7, [r14, #60]
    ldrsh.w r8, [r14, #1356]
    ldrsh.w r10, [r14, #492]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #660]
    str.w r5, [r0, #1524]
    str.w r6, [r0, #2388]
    str.w r7, [r0, #3252]
    str.w r8, [r1, #660]
    str.w r9, [r1, #1524]
    str.w r10, [r1, #2388]
    str.w r11, [r1, #3252]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1196]
    ldrsh.w r8, [r14, #332]
    ldrsh.w r9, [r14, #1628]
    ldrsh.w r11, [r14, #764]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #664]
    str.w r5, [r0, #1528]
    str.w r6, [r0, #2392]
    str.w r7, [r0, #3256]
    str.w r8, [r1, #664]
    str.w r9, [r1, #1528]
    str.w r10, [r1, #2392]
    str.w r11, [r1, #3256]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1036]
    ldrsh.w r6, [r14, #172]
    ldrsh.w r7, [r14, #1468]
    ldrsh.w r9, [r14, #604]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #668]
    str.w r5, [r0, #1532]
    str.w r6, [r0, #2396]
    str.w r7, [r0, #3260]
    str.w r8, [r1, #668]
    str.w r9, [r1, #1532]
    str.w r10, [r1, #2396]
    str.w r11, [r1, #3260]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #12]
    ldrsh.w r5, [r14, #1308]
    ldrsh.w r7, [r14, #444]
    ldrsh.w r10, [r14, #876]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #672]
    str.w r5, [r0, #1536]
    str.w r6, [r0, #2400]
    str.w r7, [r0, #3264]
    str.w r8, [r1, #672]
    str.w r9, [r1, #1536]
    str.w r10, [r1, #2400]
    str.w r11, [r1, #3264]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #284]
    ldrsh.w r6, [r14, #1580]
    ldrsh.w r8, [r14, #716]
    ldrsh.w r11, [r14, #1148]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #676]
    str.w r5, [r0, #1540]
    str.w r6, [r0, #2404]
    str.w r7, [r0, #3268]
    str.w r8, [r1, #676]
    str.w r9, [r1, #1540]
    str.w r10, [r1, #2404]
    str.w r11, [r1, #3268]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1420]
    ldrsh.w r6, [r14, #556]
    ldrsh.w r9, [r14, #988]
    ldrsh.w r11, [r14, #124]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #680]
    str.w r5, [r0, #1544]
    str.w r6, [r0, #2408]
    str.w r7, [r0, #3272]
    str.w r8, [r1, #680]
    str.w r9, [r1, #1544]
    str.w r10, [r1, #2408]
    str.w r11, [r1, #3272]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #396]
    ldrsh.w r5, [r14, #1692]
    ldrsh.w r7, [r14, #828]
    ldrsh.w r10, [r14, #1260]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #684]
    str.w r5, [r0, #1548]
    str.w r6, [r0, #2412]
    str.w r7, [r0, #3276]
    str.w r8, [r1, #684]
    str.w r9, [r1, #1548]
    str.w r10, [r1, #2412]
    str.w r11, [r1, #3276]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #668]
    ldrsh.w r8, [r14, #1100]
    ldrsh.w r10, [r14, #236]
    ldrsh.w r11, [r14, #1532]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #688]
    str.w r5, [r0, #1552]
    str.w r6, [r0, #2416]
    str.w r7, [r0, #3280]
    str.w r8, [r1, #688]
    str.w r9, [r1, #1552]
    str.w r10, [r1, #2416]
    str.w r11, [r1, #3280]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #940]
    ldrsh.w r8, [r14, #76]
    ldrsh.w r9, [r14, #1372]
    ldrsh.w r11, [r14, #508]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #692]
    str.w r5, [r0, #1556]
    str.w r6, [r0, #2420]
    str.w r7, [r0, #3284]
    str.w r8, [r1, #692]
    str.w r9, [r1, #1556]
    str.w r10, [r1, #2420]
    str.w r11, [r1, #3284]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #780]
    ldrsh.w r7, [r14, #1212]
    ldrsh.w r9, [r14, #348]
    ldrsh.w r10, [r14, #1644]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #696]
    str.w r5, [r0, #1560]
    str.w r6, [r0, #2424]
    str.w r7, [r0, #3288]
    str.w r8, [r1, #696]
    str.w r9, [r1, #1560]
    str.w r10, [r1, #2424]
    str.w r11, [r1, #3288]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1052]
    ldrsh.w r7, [r14, #188]
    ldrsh.w r8, [r14, #1484]
    ldrsh.w r10, [r14, #620]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #700]
    str.w r5, [r0, #1564]
    str.w r6, [r0, #2428]
    str.w r7, [r0, #3292]
    str.w r8, [r1, #700]
    str.w r9, [r1, #1564]
    str.w r10, [r1, #2428]
    str.w r11, [r1, #3292]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #28]
    ldrsh.w r6, [r14, #1324]
    ldrsh.w r8, [r14, #460]
    ldrsh.w r11, [r14, #892]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #704]
    str.w r5, [r0, #1568]
    str.w r6, [r0, #2432]
    str.w r7, [r0, #3296]
    str.w r8, [r1, #704]
    str.w r9, [r1, #1568]
    str.w r10, [r1, #2432]
    str.w r11, [r1, #3296]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1164]
    ldrsh.w r6, [r14, #300]
    ldrsh.w r7, [r14, #1596]
    ldrsh.w r9, [r14, #732]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #708]
    str.w r5, [r0, #1572]
    str.w r6, [r0, #2436]
    str.w r7, [r0, #3300]
    str.w r8, [r1, #708]
    str.w r9, [r1, #1572]
    str.w r10, [r1, #2436]
    str.w r11, [r1, #3300]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #140]
    ldrsh.w r5, [r14, #1436]
    ldrsh.w r7, [r14, #572]
    ldrsh.w r10, [r14, #1004]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #712]
    str.w r5, [r0, #1576]
    str.w r6, [r0, #2440]
    str.w r7, [r0, #3304]
    str.w r8, [r1, #712]
    str.w r9, [r1, #1576]
    str.w r10, [r1, #2440]
    str.w r11, [r1, #3304]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #412]
    ldrsh.w r6, [r14, #1708]
    ldrsh.w r8, [r14, #844]
    ldrsh.w r11, [r14, #1276]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #716]
    str.w r5, [r0, #1580]
    str.w r6, [r0, #2444]
    str.w r7, [r0, #3308]
    str.w r8, [r1, #716]
    str.w r9, [r1, #1580]
    str.w r10, [r1, #2444]
    str.w r11, [r1, #3308]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1548]
    ldrsh.w r6, [r14, #684]
    ldrsh.w r9, [r14, #1116]
    ldrsh.w r11, [r14, #252]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #720]
    str.w r5, [r0, #1584]
    str.w r6, [r0, #2448]
    str.w r7, [r0, #3312]
    str.w r8, [r1, #720]
    str.w r9, [r1, #1584]
    str.w r10, [r1, #2448]
    str.w r11, [r1, #3312]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #524]
    ldrsh.w r7, [r14, #956]
    ldrsh.w r9, [r14, #92]
    ldrsh.w r10, [r14, #1388]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #724]
    str.w r5, [r0, #1588]
    str.w r6, [r0, #2452]
    str.w r7, [r0, #3316]
    str.w r8, [r1, #724]
    str.w r9, [r1, #1588]
    str.w r10, [r1, #2452]
    str.w r11, [r1, #3316]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #796]
    ldrsh.w r8, [r14, #1228]
    ldrsh.w r10, [r14, #364]
    ldrsh.w r11, [r14, #1660]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #728]
    str.w r5, [r0, #1592]
    str.w r6, [r0, #2456]
    str.w r7, [r0, #3320]
    str.w r8, [r1, #728]
    str.w r9, [r1, #1592]
    str.w r10, [r1, #2456]
    str.w r11, [r1, #3320]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1068]
    ldrsh.w r8, [r14, #204]
    ldrsh.w r9, [r14, #1500]
    ldrsh.w r11, [r14, #636]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #732]
    str.w r5, [r0, #1596]
    str.w r6, [r0, #2460]
    str.w r7, [r0, #3324]
    str.w r8, [r1, #732]
    str.w r9, [r1, #1596]
    str.w r10, [r1, #2460]
    str.w r11, [r1, #3324]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #908]
    ldrsh.w r6, [r14, #44]
    ldrsh.w r7, [r14, #1340]
    ldrsh.w r9, [r14, #476]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #736]
    str.w r5, [r0, #1600]
    str.w r6, [r0, #2464]
    str.w r7, [r0, #3328]
    str.w r8, [r1, #736]
    str.w r9, [r1, #1600]
    str.w r10, [r1, #2464]
    str.w r11, [r1, #3328]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1180]
    ldrsh.w r7, [r14, #316]
    ldrsh.w r8, [r14, #1612]
    ldrsh.w r10, [r14, #748]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #740]
    str.w r5, [r0, #1604]
    str.w r6, [r0, #2468]
    str.w r7, [r0, #3332]
    str.w r8, [r1, #740]
    str.w r9, [r1, #1604]
    str.w r10, [r1, #2468]
    str.w r11, [r1, #3332]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #156]
    ldrsh.w r6, [r14, #1452]
    ldrsh.w r8, [r14, #588]
    ldrsh.w r11, [r14, #1020]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #744]
    str.w r5, [r0, #1608]
    str.w r6, [r0, #2472]
    str.w r7, [r0, #3336]
    str.w r8, [r1, #744]
    str.w r9, [r1, #1608]
    str.w r10, [r1, #2472]
    str.w r11, [r1, #3336]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1292]
    ldrsh.w r6, [r14, #428]
    ldrsh.w r9, [r14, #860]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #748]
    str.w r5, [r0, #1612]
    str.w r6, [r0, #2476]
    str.w r7, [r0, #3340]
    str.w r8, [r1, #748]
    str.w r9, [r1, #1612]
    str.w r10, [r1, #2476]
    str.w r11, [r1, #3340]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #268]
    ldrsh.w r5, [r14, #1564]
    ldrsh.w r7, [r14, #700]
    ldrsh.w r10, [r14, #1132]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #752]
    str.w r5, [r0, #1616]
    str.w r6, [r0, #2480]
    str.w r7, [r0, #3344]
    str.w r8, [r1, #752]
    str.w r9, [r1, #1616]
    str.w r10, [r1, #2480]
    str.w r11, [r1, #3344]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #270]
    ldrsh.w r5, [r14, #1566]
    ldrsh.w r7, [r14, #702]
    ldrsh.w r10, [r14, #1134]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #756]
    str.w r5, [r0, #1620]
    str.w r6, [r0, #2484]
    str.w r7, [r0, #3348]
    str.w r8, [r1, #756]
    str.w r9, [r1, #1620]
    str.w r10, [r1, #2484]
    str.w r11, [r1, #3348]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #542]
    ldrsh.w r8, [r14, #974]
    ldrsh.w r10, [r14, #110]
    ldrsh.w r11, [r14, #1406]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #760]
    str.w r5, [r0, #1624]
    str.w r6, [r0, #2488]
    str.w r7, [r0, #3352]
    str.w r8, [r1, #760]
    str.w r9, [r1, #1624]
    str.w r10, [r1, #2488]
    str.w r11, [r1, #3352]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1678]
    ldrsh.w r6, [r14, #814]
    ldrsh.w r9, [r14, #1246]
    ldrsh.w r11, [r14, #382]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #764]
    str.w r5, [r0, #1628]
    str.w r6, [r0, #2492]
    str.w r7, [r0, #3356]
    str.w r8, [r1, #764]
    str.w r9, [r1, #1628]
    str.w r10, [r1, #2492]
    str.w r11, [r1, #3356]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #654]
    ldrsh.w r7, [r14, #1086]
    ldrsh.w r9, [r14, #222]
    ldrsh.w r10, [r14, #1518]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #768]
    str.w r5, [r0, #1632]
    str.w r6, [r0, #2496]
    str.w r7, [r0, #3360]
    str.w r8, [r1, #768]
    str.w r9, [r1, #1632]
    str.w r10, [r1, #2496]
    str.w r11, [r1, #3360]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #926]
    ldrsh.w r7, [r14, #62]
    ldrsh.w r8, [r14, #1358]
    ldrsh.w r10, [r14, #494]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #772]
    str.w r5, [r0, #1636]
    str.w r6, [r0, #2500]
    str.w r7, [r0, #3364]
    str.w r8, [r1, #772]
    str.w r9, [r1, #1636]
    str.w r10, [r1, #2500]
    str.w r11, [r1, #3364]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1198]
    ldrsh.w r8, [r14, #334]
    ldrsh.w r9, [r14, #1630]
    ldrsh.w r11, [r14, #766]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #776]
    str.w r5, [r0, #1640]
    str.w r6, [r0, #2504]
    str.w r7, [r0, #3368]
    str.w r8, [r1, #776]
    str.w r9, [r1, #1640]
    str.w r10, [r1, #2504]
    str.w r11, [r1, #3368]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1038]
    ldrsh.w r6, [r14, #174]
    ldrsh.w r7, [r14, #1470]
    ldrsh.w r9, [r14, #606]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #780]
    str.w r5, [r0, #1644]
    str.w r6, [r0, #2508]
    str.w r7, [r0, #3372]
    str.w r8, [r1, #780]
    str.w r9, [r1, #1644]
    str.w r10, [r1, #2508]
    str.w r11, [r1, #3372]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #14]
    ldrsh.w r5, [r14, #1310]
    ldrsh.w r7, [r14, #446]
    ldrsh.w r10, [r14, #878]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #784]
    str.w r5, [r0, #1648]
    str.w r6, [r0, #2512]
    str.w r7, [r0, #3376]
    str.w r8, [r1, #784]
    str.w r9, [r1, #1648]
    str.w r10, [r1, #2512]
    str.w r11, [r1, #3376]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #286]
    ldrsh.w r6, [r14, #1582]
    ldrsh.w r8, [r14, #718]
    ldrsh.w r11, [r14, #1150]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #788]
    str.w r5, [r0, #1652]
    str.w r6, [r0, #2516]
    str.w r7, [r0, #3380]
    str.w r8, [r1, #788]
    str.w r9, [r1, #1652]
    str.w r10, [r1, #2516]
    str.w r11, [r1, #3380]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1422]
    ldrsh.w r6, [r14, #558]
    ldrsh.w r9, [r14, #990]
    ldrsh.w r11, [r14, #126]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #792]
    str.w r5, [r0, #1656]
    str.w r6, [r0, #2520]
    str.w r7, [r0, #3384]
    str.w r8, [r1, #792]
    str.w r9, [r1, #1656]
    str.w r10, [r1, #2520]
    str.w r11, [r1, #3384]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #398]
    ldrsh.w r5, [r14, #1694]
    ldrsh.w r7, [r14, #830]
    ldrsh.w r10, [r14, #1262]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #796]
    str.w r5, [r0, #1660]
    str.w r6, [r0, #2524]
    str.w r7, [r0, #3388]
    str.w r8, [r1, #796]
    str.w r9, [r1, #1660]
    str.w r10, [r1, #2524]
    str.w r11, [r1, #3388]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #670]
    ldrsh.w r8, [r14, #1102]
    ldrsh.w r10, [r14, #238]
    ldrsh.w r11, [r14, #1534]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #800]
    str.w r5, [r0, #1664]
    str.w r6, [r0, #2528]
    str.w r7, [r0, #3392]
    str.w r8, [r1, #800]
    str.w r9, [r1, #1664]
    str.w r10, [r1, #2528]
    str.w r11, [r1, #3392]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #942]
    ldrsh.w r8, [r14, #78]
    ldrsh.w r9, [r14, #1374]
    ldrsh.w r11, [r14, #510]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #804]
    str.w r5, [r0, #1668]
    str.w r6, [r0, #2532]
    str.w r7, [r0, #3396]
    str.w r8, [r1, #804]
    str.w r9, [r1, #1668]
    str.w r10, [r1, #2532]
    str.w r11, [r1, #3396]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #782]
    ldrsh.w r7, [r14, #1214]
    ldrsh.w r9, [r14, #350]
    ldrsh.w r10, [r14, #1646]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #808]
    str.w r5, [r0, #1672]
    str.w r6, [r0, #2536]
    str.w r7, [r0, #3400]
    str.w r8, [r1, #808]
    str.w r9, [r1, #1672]
    str.w r10, [r1, #2536]
    str.w r11, [r1, #3400]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1054]
    ldrsh.w r7, [r14, #190]
    ldrsh.w r8, [r14, #1486]
    ldrsh.w r10, [r14, #622]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #812]
    str.w r5, [r0, #1676]
    str.w r6, [r0, #2540]
    str.w r7, [r0, #3404]
    str.w r8, [r1, #812]
    str.w r9, [r1, #1676]
    str.w r10, [r1, #2540]
    str.w r11, [r1, #3404]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #30]
    ldrsh.w r6, [r14, #1326]
    ldrsh.w r8, [r14, #462]
    ldrsh.w r11, [r14, #894]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #816]
    str.w r5, [r0, #1680]
    str.w r6, [r0, #2544]
    str.w r7, [r0, #3408]
    str.w r8, [r1, #816]
    str.w r9, [r1, #1680]
    str.w r10, [r1, #2544]
    str.w r11, [r1, #3408]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1166]
    ldrsh.w r6, [r14, #302]
    ldrsh.w r7, [r14, #1598]
    ldrsh.w r9, [r14, #734]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #820]
    str.w r5, [r0, #1684]
    str.w r6, [r0, #2548]
    str.w r7, [r0, #3412]
    str.w r8, [r1, #820]
    str.w r9, [r1, #1684]
    str.w r10, [r1, #2548]
    str.w r11, [r1, #3412]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #142]
    ldrsh.w r5, [r14, #1438]
    ldrsh.w r7, [r14, #574]
    ldrsh.w r10, [r14, #1006]
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #824]
    str.w r5, [r0, #1688]
    str.w r6, [r0, #2552]
    str.w r7, [r0, #3416]
    str.w r8, [r1, #824]
    str.w r9, [r1, #1688]
    str.w r10, [r1, #2552]
    str.w r11, [r1, #3416]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #414]
    ldrsh.w r6, [r14, #1710]
    ldrsh.w r8, [r14, #846]
    ldrsh.w r11, [r14, #1278]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #828]
    str.w r5, [r0, #1692]
    str.w r6, [r0, #2556]
    str.w r7, [r0, #3420]
    str.w r8, [r1, #828]
    str.w r9, [r1, #1692]
    str.w r10, [r1, #2556]
    str.w r11, [r1, #3420]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1550]
    ldrsh.w r6, [r14, #686]
    ldrsh.w r9, [r14, #1118]
    ldrsh.w r11, [r14, #254]
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #832]
    str.w r5, [r0, #1696]
    str.w r6, [r0, #2560]
    str.w r7, [r0, #3424]
    str.w r8, [r1, #832]
    str.w r9, [r1, #1696]
    str.w r10, [r1, #2560]
    str.w r11, [r1, #3424]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #526]
    ldrsh.w r7, [r14, #958]
    ldrsh.w r9, [r14, #94]
    ldrsh.w r10, [r14, #1390]
    _3_layer_CT_butterfly_type_1001 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #836]
    str.w r5, [r0, #1700]
    str.w r6, [r0, #2564]
    str.w r7, [r0, #3428]
    str.w r8, [r1, #836]
    str.w r9, [r1, #1700]
    str.w r10, [r1, #2564]
    str.w r11, [r1, #3428]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #798]
    ldrsh.w r8, [r14, #1230]
    ldrsh.w r10, [r14, #366]
    ldrsh.w r11, [r14, #1662]
    _3_layer_CT_butterfly_type_0100 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #840]
    str.w r5, [r0, #1704]
    str.w r6, [r0, #2568]
    str.w r7, [r0, #3432]
    str.w r8, [r1, #840]
    str.w r9, [r1, #1704]
    str.w r10, [r1, #2568]
    str.w r11, [r1, #3432]
    vmov.w r14, s0
    ldrsh.w r6, [r14, #1070]
    ldrsh.w r8, [r14, #206]
    ldrsh.w r9, [r14, #1502]
    ldrsh.w r11, [r14, #638]
    _3_layer_CT_butterfly_type_0010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #844]
    str.w r5, [r0, #1708]
    str.w r6, [r0, #2572]
    str.w r7, [r0, #3436]
    str.w r8, [r1, #844]
    str.w r9, [r1, #1708]
    str.w r10, [r1, #2572]
    str.w r11, [r1, #3436]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #910]
    ldrsh.w r6, [r14, #46]
    ldrsh.w r7, [r14, #1342]
    ldrsh.w r9, [r14, #478]
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #848]
    str.w r5, [r0, #1712]
    str.w r6, [r0, #2576]
    str.w r7, [r0, #3440]
    str.w r8, [r1, #848]
    str.w r9, [r1, #1712]
    str.w r10, [r1, #2576]
    str.w r11, [r1, #3440]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #1182]
    ldrsh.w r7, [r14, #318]
    ldrsh.w r8, [r14, #1614]
    ldrsh.w r10, [r14, #750]
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #852]
    str.w r5, [r0, #1716]
    str.w r6, [r0, #2580]
    str.w r7, [r0, #3444]
    str.w r8, [r1, #852]
    str.w r9, [r1, #1716]
    str.w r10, [r1, #2580]
    str.w r11, [r1, #3444]
    vmov.w r14, s0
    ldrsh.w r5, [r14, #158]
    ldrsh.w r6, [r14, #1454]
    ldrsh.w r8, [r14, #590]
    ldrsh.w r11, [r14, #1022]
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #856]
    str.w r5, [r0, #1720]
    str.w r6, [r0, #2584]
    str.w r7, [r0, #3448]
    str.w r8, [r1, #856]
    str.w r9, [r1, #1720]
    str.w r10, [r1, #2584]
    str.w r11, [r1, #3448]
    vmov.w r14, s0
    ldrsh.w r4, [r14, #1294]
    ldrsh.w r6, [r14, #430]
    ldrsh.w r9, [r14, #862]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #860]
    str.w r5, [r0, #1724]
    str.w r6, [r0, #2588]
    str.w r7, [r0, #3452]
    str.w r8, [r1, #860]
    str.w r9, [r1, #1724]
    str.w r10, [r1, #2588]
    str.w r11, [r1, #3452]

    pop {r4-r12, pc}

.align 2
.global __asm_Good_64x27_small
.type __asm_Good_64x27_small, %function
__asm_Good_64x27_small:
    push {r4-r12, lr}
    ldr.w r14, [sp, #40]

    add.w r12, r0, #3456

    vmov.w s0, s1, r14, r12

    vldm r1, {s4-s10}

        vmov.w r14, s0
    ldrsb.w r4, [r14, #0]
    ldrsb.w r5, [r14, #648]
    ldrsb.w r7, [r14, #216]
    ldrsb.w r10, [r14, #432]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #0]
    str.w r5, [r0, #864]
    str.w r6, [r0, #1728]
    str.w r7, [r0, #2592]
    str.w r8, [r1, #0]
    str.w r9, [r1, #864]
    str.w r10, [r1, #1728]
    str.w r11, [r1, #2592]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #136]
    ldrsb.w r6, [r14, #784]
    ldrsb.w r8, [r14, #352]
    ldrsb.w r11, [r14, #568]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #4]
    str.w r5, [r0, #868]
    str.w r6, [r0, #1732]
    str.w r7, [r0, #2596]
    str.w r8, [r1, #4]
    str.w r9, [r1, #868]
    str.w r10, [r1, #1732]
    str.w r11, [r1, #2596]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #704]
    ldrsb.w r6, [r14, #272]
    ldrsb.w r9, [r14, #488]
    ldrsb.w r11, [r14, #56]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #8]
    str.w r5, [r0, #872]
    str.w r6, [r0, #1736]
    str.w r7, [r0, #2600]
    str.w r8, [r1, #8]
    str.w r9, [r1, #872]
    str.w r10, [r1, #1736]
    str.w r11, [r1, #2600]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #192]
    ldrsb.w r5, [r14, #840]
    ldrsb.w r7, [r14, #408]
    ldrsb.w r10, [r14, #624]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #12]
    str.w r5, [r0, #876]
    str.w r6, [r0, #1740]
    str.w r7, [r0, #2604]
    str.w r8, [r1, #12]
    str.w r9, [r1, #876]
    str.w r10, [r1, #1740]
    str.w r11, [r1, #2604]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #328]
    ldrsb.w r8, [r14, #544]
    ldrsb.w r10, [r14, #112]
    ldrsb.w r11, [r14, #760]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #16]
    str.w r5, [r0, #880]
    str.w r6, [r0, #1744]
    str.w r7, [r0, #2608]
    str.w r8, [r1, #16]
    str.w r9, [r1, #880]
    str.w r10, [r1, #1744]
    str.w r11, [r1, #2608]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #464]
    ldrsb.w r8, [r14, #32]
    ldrsb.w r9, [r14, #680]
    ldrsb.w r11, [r14, #248]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #20]
    str.w r5, [r0, #884]
    str.w r6, [r0, #1748]
    str.w r7, [r0, #2612]
    str.w r8, [r1, #20]
    str.w r9, [r1, #884]
    str.w r10, [r1, #1748]
    str.w r11, [r1, #2612]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #384]
    ldrsb.w r7, [r14, #600]
    ldrsb.w r9, [r14, #168]
    ldrsb.w r10, [r14, #816]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #24]
    str.w r5, [r0, #888]
    str.w r6, [r0, #1752]
    str.w r7, [r0, #2616]
    str.w r8, [r1, #24]
    str.w r9, [r1, #888]
    str.w r10, [r1, #1752]
    str.w r11, [r1, #2616]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #520]
    ldrsb.w r7, [r14, #88]
    ldrsb.w r8, [r14, #736]
    ldrsb.w r10, [r14, #304]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #28]
    str.w r5, [r0, #892]
    str.w r6, [r0, #1756]
    str.w r7, [r0, #2620]
    str.w r8, [r1, #28]
    str.w r9, [r1, #892]
    str.w r10, [r1, #1756]
    str.w r11, [r1, #2620]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #8]
    ldrsb.w r6, [r14, #656]
    ldrsb.w r8, [r14, #224]
    ldrsb.w r11, [r14, #440]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #32]
    str.w r5, [r0, #896]
    str.w r6, [r0, #1760]
    str.w r7, [r0, #2624]
    str.w r8, [r1, #32]
    str.w r9, [r1, #896]
    str.w r10, [r1, #1760]
    str.w r11, [r1, #2624]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #576]
    ldrsb.w r6, [r14, #144]
    ldrsb.w r7, [r14, #792]
    ldrsb.w r9, [r14, #360]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #36]
    str.w r5, [r0, #900]
    str.w r6, [r0, #1764]
    str.w r7, [r0, #2628]
    str.w r8, [r1, #36]
    str.w r9, [r1, #900]
    str.w r10, [r1, #1764]
    str.w r11, [r1, #2628]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #64]
    ldrsb.w r5, [r14, #712]
    ldrsb.w r7, [r14, #280]
    ldrsb.w r10, [r14, #496]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #40]
    str.w r5, [r0, #904]
    str.w r6, [r0, #1768]
    str.w r7, [r0, #2632]
    str.w r8, [r1, #40]
    str.w r9, [r1, #904]
    str.w r10, [r1, #1768]
    str.w r11, [r1, #2632]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #200]
    ldrsb.w r6, [r14, #848]
    ldrsb.w r8, [r14, #416]
    ldrsb.w r11, [r14, #632]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #44]
    str.w r5, [r0, #908]
    str.w r6, [r0, #1772]
    str.w r7, [r0, #2636]
    str.w r8, [r1, #44]
    str.w r9, [r1, #908]
    str.w r10, [r1, #1772]
    str.w r11, [r1, #2636]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #768]
    ldrsb.w r6, [r14, #336]
    ldrsb.w r9, [r14, #552]
    ldrsb.w r11, [r14, #120]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #48]
    str.w r5, [r0, #912]
    str.w r6, [r0, #1776]
    str.w r7, [r0, #2640]
    str.w r8, [r1, #48]
    str.w r9, [r1, #912]
    str.w r10, [r1, #1776]
    str.w r11, [r1, #2640]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #256]
    ldrsb.w r7, [r14, #472]
    ldrsb.w r9, [r14, #40]
    ldrsb.w r10, [r14, #688]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #52]
    str.w r5, [r0, #916]
    str.w r6, [r0, #1780]
    str.w r7, [r0, #2644]
    str.w r8, [r1, #52]
    str.w r9, [r1, #916]
    str.w r10, [r1, #1780]
    str.w r11, [r1, #2644]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #392]
    ldrsb.w r8, [r14, #608]
    ldrsb.w r10, [r14, #176]
    ldrsb.w r11, [r14, #824]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #56]
    str.w r5, [r0, #920]
    str.w r6, [r0, #1784]
    str.w r7, [r0, #2648]
    str.w r8, [r1, #56]
    str.w r9, [r1, #920]
    str.w r10, [r1, #1784]
    str.w r11, [r1, #2648]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #528]
    ldrsb.w r8, [r14, #96]
    ldrsb.w r9, [r14, #744]
    ldrsb.w r11, [r14, #312]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #60]
    str.w r5, [r0, #924]
    str.w r6, [r0, #1788]
    str.w r7, [r0, #2652]
    str.w r8, [r1, #60]
    str.w r9, [r1, #924]
    str.w r10, [r1, #1788]
    str.w r11, [r1, #2652]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #448]
    ldrsb.w r6, [r14, #16]
    ldrsb.w r7, [r14, #664]
    ldrsb.w r9, [r14, #232]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #64]
    str.w r5, [r0, #928]
    str.w r6, [r0, #1792]
    str.w r7, [r0, #2656]
    str.w r8, [r1, #64]
    str.w r9, [r1, #928]
    str.w r10, [r1, #1792]
    str.w r11, [r1, #2656]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #584]
    ldrsb.w r7, [r14, #152]
    ldrsb.w r8, [r14, #800]
    ldrsb.w r10, [r14, #368]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #68]
    str.w r5, [r0, #932]
    str.w r6, [r0, #1796]
    str.w r7, [r0, #2660]
    str.w r8, [r1, #68]
    str.w r9, [r1, #932]
    str.w r10, [r1, #1796]
    str.w r11, [r1, #2660]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #72]
    ldrsb.w r6, [r14, #720]
    ldrsb.w r8, [r14, #288]
    ldrsb.w r11, [r14, #504]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #72]
    str.w r5, [r0, #936]
    str.w r6, [r0, #1800]
    str.w r7, [r0, #2664]
    str.w r8, [r1, #72]
    str.w r9, [r1, #936]
    str.w r10, [r1, #1800]
    str.w r11, [r1, #2664]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #640]
    ldrsb.w r6, [r14, #208]
    ldrsb.w r7, [r14, #856]
    ldrsb.w r9, [r14, #424]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #76]
    str.w r5, [r0, #940]
    str.w r6, [r0, #1804]
    str.w r7, [r0, #2668]
    str.w r8, [r1, #76]
    str.w r9, [r1, #940]
    str.w r10, [r1, #1804]
    str.w r11, [r1, #2668]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #128]
    ldrsb.w r5, [r14, #776]
    ldrsb.w r7, [r14, #344]
    ldrsb.w r10, [r14, #560]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #80]
    str.w r5, [r0, #944]
    str.w r6, [r0, #1808]
    str.w r7, [r0, #2672]
    str.w r8, [r1, #80]
    str.w r9, [r1, #944]
    str.w r10, [r1, #1808]
    str.w r11, [r1, #2672]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #264]
    ldrsb.w r8, [r14, #480]
    ldrsb.w r10, [r14, #48]
    ldrsb.w r11, [r14, #696]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #84]
    str.w r5, [r0, #948]
    str.w r6, [r0, #1812]
    str.w r7, [r0, #2676]
    str.w r8, [r1, #84]
    str.w r9, [r1, #948]
    str.w r10, [r1, #1812]
    str.w r11, [r1, #2676]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #832]
    ldrsb.w r6, [r14, #400]
    ldrsb.w r9, [r14, #616]
    ldrsb.w r11, [r14, #184]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #88]
    str.w r5, [r0, #952]
    str.w r6, [r0, #1816]
    str.w r7, [r0, #2680]
    str.w r8, [r1, #88]
    str.w r9, [r1, #952]
    str.w r10, [r1, #1816]
    str.w r11, [r1, #2680]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #320]
    ldrsb.w r7, [r14, #536]
    ldrsb.w r9, [r14, #104]
    ldrsb.w r10, [r14, #752]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #92]
    str.w r5, [r0, #956]
    str.w r6, [r0, #1820]
    str.w r7, [r0, #2684]
    str.w r8, [r1, #92]
    str.w r9, [r1, #956]
    str.w r10, [r1, #1820]
    str.w r11, [r1, #2684]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #456]
    ldrsb.w r7, [r14, #24]
    ldrsb.w r8, [r14, #672]
    ldrsb.w r10, [r14, #240]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #96]
    str.w r5, [r0, #960]
    str.w r6, [r0, #1824]
    str.w r7, [r0, #2688]
    str.w r8, [r1, #96]
    str.w r9, [r1, #960]
    str.w r10, [r1, #1824]
    str.w r11, [r1, #2688]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #592]
    ldrsb.w r8, [r14, #160]
    ldrsb.w r9, [r14, #808]
    ldrsb.w r11, [r14, #376]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #100]
    str.w r5, [r0, #964]
    str.w r6, [r0, #1828]
    str.w r7, [r0, #2692]
    str.w r8, [r1, #100]
    str.w r9, [r1, #964]
    str.w r10, [r1, #1828]
    str.w r11, [r1, #2692]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #512]
    ldrsb.w r6, [r14, #80]
    ldrsb.w r7, [r14, #728]
    ldrsb.w r9, [r14, #296]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #104]
    str.w r5, [r0, #968]
    str.w r6, [r0, #1832]
    str.w r7, [r0, #2696]
    str.w r8, [r1, #104]
    str.w r9, [r1, #968]
    str.w r10, [r1, #1832]
    str.w r11, [r1, #2696]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #513]
    ldrsb.w r6, [r14, #81]
    ldrsb.w r7, [r14, #729]
    ldrsb.w r9, [r14, #297]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #108]
    str.w r5, [r0, #972]
    str.w r6, [r0, #1836]
    str.w r7, [r0, #2700]
    str.w r8, [r1, #108]
    str.w r9, [r1, #972]
    str.w r10, [r1, #1836]
    str.w r11, [r1, #2700]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #1]
    ldrsb.w r5, [r14, #649]
    ldrsb.w r7, [r14, #217]
    ldrsb.w r10, [r14, #433]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #112]
    str.w r5, [r0, #976]
    str.w r6, [r0, #1840]
    str.w r7, [r0, #2704]
    str.w r8, [r1, #112]
    str.w r9, [r1, #976]
    str.w r10, [r1, #1840]
    str.w r11, [r1, #2704]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #137]
    ldrsb.w r6, [r14, #785]
    ldrsb.w r8, [r14, #353]
    ldrsb.w r11, [r14, #569]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #116]
    str.w r5, [r0, #980]
    str.w r6, [r0, #1844]
    str.w r7, [r0, #2708]
    str.w r8, [r1, #116]
    str.w r9, [r1, #980]
    str.w r10, [r1, #1844]
    str.w r11, [r1, #2708]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #705]
    ldrsb.w r6, [r14, #273]
    ldrsb.w r9, [r14, #489]
    ldrsb.w r11, [r14, #57]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #120]
    str.w r5, [r0, #984]
    str.w r6, [r0, #1848]
    str.w r7, [r0, #2712]
    str.w r8, [r1, #120]
    str.w r9, [r1, #984]
    str.w r10, [r1, #1848]
    str.w r11, [r1, #2712]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #193]
    ldrsb.w r5, [r14, #841]
    ldrsb.w r7, [r14, #409]
    ldrsb.w r10, [r14, #625]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #124]
    str.w r5, [r0, #988]
    str.w r6, [r0, #1852]
    str.w r7, [r0, #2716]
    str.w r8, [r1, #124]
    str.w r9, [r1, #988]
    str.w r10, [r1, #1852]
    str.w r11, [r1, #2716]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #329]
    ldrsb.w r8, [r14, #545]
    ldrsb.w r10, [r14, #113]
    ldrsb.w r11, [r14, #761]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #128]
    str.w r5, [r0, #992]
    str.w r6, [r0, #1856]
    str.w r7, [r0, #2720]
    str.w r8, [r1, #128]
    str.w r9, [r1, #992]
    str.w r10, [r1, #1856]
    str.w r11, [r1, #2720]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #465]
    ldrsb.w r8, [r14, #33]
    ldrsb.w r9, [r14, #681]
    ldrsb.w r11, [r14, #249]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #132]
    str.w r5, [r0, #996]
    str.w r6, [r0, #1860]
    str.w r7, [r0, #2724]
    str.w r8, [r1, #132]
    str.w r9, [r1, #996]
    str.w r10, [r1, #1860]
    str.w r11, [r1, #2724]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #385]
    ldrsb.w r7, [r14, #601]
    ldrsb.w r9, [r14, #169]
    ldrsb.w r10, [r14, #817]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #136]
    str.w r5, [r0, #1000]
    str.w r6, [r0, #1864]
    str.w r7, [r0, #2728]
    str.w r8, [r1, #136]
    str.w r9, [r1, #1000]
    str.w r10, [r1, #1864]
    str.w r11, [r1, #2728]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #521]
    ldrsb.w r7, [r14, #89]
    ldrsb.w r8, [r14, #737]
    ldrsb.w r10, [r14, #305]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #140]
    str.w r5, [r0, #1004]
    str.w r6, [r0, #1868]
    str.w r7, [r0, #2732]
    str.w r8, [r1, #140]
    str.w r9, [r1, #1004]
    str.w r10, [r1, #1868]
    str.w r11, [r1, #2732]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #9]
    ldrsb.w r6, [r14, #657]
    ldrsb.w r8, [r14, #225]
    ldrsb.w r11, [r14, #441]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #144]
    str.w r5, [r0, #1008]
    str.w r6, [r0, #1872]
    str.w r7, [r0, #2736]
    str.w r8, [r1, #144]
    str.w r9, [r1, #1008]
    str.w r10, [r1, #1872]
    str.w r11, [r1, #2736]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #577]
    ldrsb.w r6, [r14, #145]
    ldrsb.w r7, [r14, #793]
    ldrsb.w r9, [r14, #361]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #148]
    str.w r5, [r0, #1012]
    str.w r6, [r0, #1876]
    str.w r7, [r0, #2740]
    str.w r8, [r1, #148]
    str.w r9, [r1, #1012]
    str.w r10, [r1, #1876]
    str.w r11, [r1, #2740]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #65]
    ldrsb.w r5, [r14, #713]
    ldrsb.w r7, [r14, #281]
    ldrsb.w r10, [r14, #497]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #152]
    str.w r5, [r0, #1016]
    str.w r6, [r0, #1880]
    str.w r7, [r0, #2744]
    str.w r8, [r1, #152]
    str.w r9, [r1, #1016]
    str.w r10, [r1, #1880]
    str.w r11, [r1, #2744]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #201]
    ldrsb.w r6, [r14, #849]
    ldrsb.w r8, [r14, #417]
    ldrsb.w r11, [r14, #633]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #156]
    str.w r5, [r0, #1020]
    str.w r6, [r0, #1884]
    str.w r7, [r0, #2748]
    str.w r8, [r1, #156]
    str.w r9, [r1, #1020]
    str.w r10, [r1, #1884]
    str.w r11, [r1, #2748]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #769]
    ldrsb.w r6, [r14, #337]
    ldrsb.w r9, [r14, #553]
    ldrsb.w r11, [r14, #121]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #160]
    str.w r5, [r0, #1024]
    str.w r6, [r0, #1888]
    str.w r7, [r0, #2752]
    str.w r8, [r1, #160]
    str.w r9, [r1, #1024]
    str.w r10, [r1, #1888]
    str.w r11, [r1, #2752]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #257]
    ldrsb.w r7, [r14, #473]
    ldrsb.w r9, [r14, #41]
    ldrsb.w r10, [r14, #689]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #164]
    str.w r5, [r0, #1028]
    str.w r6, [r0, #1892]
    str.w r7, [r0, #2756]
    str.w r8, [r1, #164]
    str.w r9, [r1, #1028]
    str.w r10, [r1, #1892]
    str.w r11, [r1, #2756]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #393]
    ldrsb.w r8, [r14, #609]
    ldrsb.w r10, [r14, #177]
    ldrsb.w r11, [r14, #825]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #168]
    str.w r5, [r0, #1032]
    str.w r6, [r0, #1896]
    str.w r7, [r0, #2760]
    str.w r8, [r1, #168]
    str.w r9, [r1, #1032]
    str.w r10, [r1, #1896]
    str.w r11, [r1, #2760]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #529]
    ldrsb.w r8, [r14, #97]
    ldrsb.w r9, [r14, #745]
    ldrsb.w r11, [r14, #313]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #172]
    str.w r5, [r0, #1036]
    str.w r6, [r0, #1900]
    str.w r7, [r0, #2764]
    str.w r8, [r1, #172]
    str.w r9, [r1, #1036]
    str.w r10, [r1, #1900]
    str.w r11, [r1, #2764]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #449]
    ldrsb.w r6, [r14, #17]
    ldrsb.w r7, [r14, #665]
    ldrsb.w r9, [r14, #233]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #176]
    str.w r5, [r0, #1040]
    str.w r6, [r0, #1904]
    str.w r7, [r0, #2768]
    str.w r8, [r1, #176]
    str.w r9, [r1, #1040]
    str.w r10, [r1, #1904]
    str.w r11, [r1, #2768]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #585]
    ldrsb.w r7, [r14, #153]
    ldrsb.w r8, [r14, #801]
    ldrsb.w r10, [r14, #369]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #180]
    str.w r5, [r0, #1044]
    str.w r6, [r0, #1908]
    str.w r7, [r0, #2772]
    str.w r8, [r1, #180]
    str.w r9, [r1, #1044]
    str.w r10, [r1, #1908]
    str.w r11, [r1, #2772]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #73]
    ldrsb.w r6, [r14, #721]
    ldrsb.w r8, [r14, #289]
    ldrsb.w r11, [r14, #505]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #184]
    str.w r5, [r0, #1048]
    str.w r6, [r0, #1912]
    str.w r7, [r0, #2776]
    str.w r8, [r1, #184]
    str.w r9, [r1, #1048]
    str.w r10, [r1, #1912]
    str.w r11, [r1, #2776]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #641]
    ldrsb.w r6, [r14, #209]
    ldrsb.w r9, [r14, #425]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #188]
    str.w r5, [r0, #1052]
    str.w r6, [r0, #1916]
    str.w r7, [r0, #2780]
    str.w r8, [r1, #188]
    str.w r9, [r1, #1052]
    str.w r10, [r1, #1916]
    str.w r11, [r1, #2780]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #129]
    ldrsb.w r5, [r14, #777]
    ldrsb.w r7, [r14, #345]
    ldrsb.w r10, [r14, #561]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #192]
    str.w r5, [r0, #1056]
    str.w r6, [r0, #1920]
    str.w r7, [r0, #2784]
    str.w r8, [r1, #192]
    str.w r9, [r1, #1056]
    str.w r10, [r1, #1920]
    str.w r11, [r1, #2784]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #265]
    ldrsb.w r8, [r14, #481]
    ldrsb.w r10, [r14, #49]
    ldrsb.w r11, [r14, #697]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #196]
    str.w r5, [r0, #1060]
    str.w r6, [r0, #1924]
    str.w r7, [r0, #2788]
    str.w r8, [r1, #196]
    str.w r9, [r1, #1060]
    str.w r10, [r1, #1924]
    str.w r11, [r1, #2788]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #833]
    ldrsb.w r6, [r14, #401]
    ldrsb.w r9, [r14, #617]
    ldrsb.w r11, [r14, #185]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #200]
    str.w r5, [r0, #1064]
    str.w r6, [r0, #1928]
    str.w r7, [r0, #2792]
    str.w r8, [r1, #200]
    str.w r9, [r1, #1064]
    str.w r10, [r1, #1928]
    str.w r11, [r1, #2792]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #321]
    ldrsb.w r7, [r14, #537]
    ldrsb.w r9, [r14, #105]
    ldrsb.w r10, [r14, #753]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #204]
    str.w r5, [r0, #1068]
    str.w r6, [r0, #1932]
    str.w r7, [r0, #2796]
    str.w r8, [r1, #204]
    str.w r9, [r1, #1068]
    str.w r10, [r1, #1932]
    str.w r11, [r1, #2796]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #457]
    ldrsb.w r7, [r14, #25]
    ldrsb.w r8, [r14, #673]
    ldrsb.w r10, [r14, #241]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #208]
    str.w r5, [r0, #1072]
    str.w r6, [r0, #1936]
    str.w r7, [r0, #2800]
    str.w r8, [r1, #208]
    str.w r9, [r1, #1072]
    str.w r10, [r1, #1936]
    str.w r11, [r1, #2800]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #593]
    ldrsb.w r8, [r14, #161]
    ldrsb.w r9, [r14, #809]
    ldrsb.w r11, [r14, #377]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #212]
    str.w r5, [r0, #1076]
    str.w r6, [r0, #1940]
    str.w r7, [r0, #2804]
    str.w r8, [r1, #212]
    str.w r9, [r1, #1076]
    str.w r10, [r1, #1940]
    str.w r11, [r1, #2804]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #594]
    ldrsb.w r8, [r14, #162]
    ldrsb.w r9, [r14, #810]
    ldrsb.w r11, [r14, #378]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #216]
    str.w r5, [r0, #1080]
    str.w r6, [r0, #1944]
    str.w r7, [r0, #2808]
    str.w r8, [r1, #216]
    str.w r9, [r1, #1080]
    str.w r10, [r1, #1944]
    str.w r11, [r1, #2808]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #514]
    ldrsb.w r6, [r14, #82]
    ldrsb.w r7, [r14, #730]
    ldrsb.w r9, [r14, #298]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #220]
    str.w r5, [r0, #1084]
    str.w r6, [r0, #1948]
    str.w r7, [r0, #2812]
    str.w r8, [r1, #220]
    str.w r9, [r1, #1084]
    str.w r10, [r1, #1948]
    str.w r11, [r1, #2812]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #2]
    ldrsb.w r5, [r14, #650]
    ldrsb.w r7, [r14, #218]
    ldrsb.w r10, [r14, #434]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #224]
    str.w r5, [r0, #1088]
    str.w r6, [r0, #1952]
    str.w r7, [r0, #2816]
    str.w r8, [r1, #224]
    str.w r9, [r1, #1088]
    str.w r10, [r1, #1952]
    str.w r11, [r1, #2816]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #138]
    ldrsb.w r6, [r14, #786]
    ldrsb.w r8, [r14, #354]
    ldrsb.w r11, [r14, #570]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #228]
    str.w r5, [r0, #1092]
    str.w r6, [r0, #1956]
    str.w r7, [r0, #2820]
    str.w r8, [r1, #228]
    str.w r9, [r1, #1092]
    str.w r10, [r1, #1956]
    str.w r11, [r1, #2820]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #706]
    ldrsb.w r6, [r14, #274]
    ldrsb.w r9, [r14, #490]
    ldrsb.w r11, [r14, #58]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #232]
    str.w r5, [r0, #1096]
    str.w r6, [r0, #1960]
    str.w r7, [r0, #2824]
    str.w r8, [r1, #232]
    str.w r9, [r1, #1096]
    str.w r10, [r1, #1960]
    str.w r11, [r1, #2824]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #194]
    ldrsb.w r5, [r14, #842]
    ldrsb.w r7, [r14, #410]
    ldrsb.w r10, [r14, #626]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #236]
    str.w r5, [r0, #1100]
    str.w r6, [r0, #1964]
    str.w r7, [r0, #2828]
    str.w r8, [r1, #236]
    str.w r9, [r1, #1100]
    str.w r10, [r1, #1964]
    str.w r11, [r1, #2828]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #330]
    ldrsb.w r8, [r14, #546]
    ldrsb.w r10, [r14, #114]
    ldrsb.w r11, [r14, #762]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #240]
    str.w r5, [r0, #1104]
    str.w r6, [r0, #1968]
    str.w r7, [r0, #2832]
    str.w r8, [r1, #240]
    str.w r9, [r1, #1104]
    str.w r10, [r1, #1968]
    str.w r11, [r1, #2832]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #466]
    ldrsb.w r8, [r14, #34]
    ldrsb.w r9, [r14, #682]
    ldrsb.w r11, [r14, #250]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #244]
    str.w r5, [r0, #1108]
    str.w r6, [r0, #1972]
    str.w r7, [r0, #2836]
    str.w r8, [r1, #244]
    str.w r9, [r1, #1108]
    str.w r10, [r1, #1972]
    str.w r11, [r1, #2836]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #386]
    ldrsb.w r7, [r14, #602]
    ldrsb.w r9, [r14, #170]
    ldrsb.w r10, [r14, #818]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #248]
    str.w r5, [r0, #1112]
    str.w r6, [r0, #1976]
    str.w r7, [r0, #2840]
    str.w r8, [r1, #248]
    str.w r9, [r1, #1112]
    str.w r10, [r1, #1976]
    str.w r11, [r1, #2840]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #522]
    ldrsb.w r7, [r14, #90]
    ldrsb.w r8, [r14, #738]
    ldrsb.w r10, [r14, #306]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #252]
    str.w r5, [r0, #1116]
    str.w r6, [r0, #1980]
    str.w r7, [r0, #2844]
    str.w r8, [r1, #252]
    str.w r9, [r1, #1116]
    str.w r10, [r1, #1980]
    str.w r11, [r1, #2844]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #10]
    ldrsb.w r6, [r14, #658]
    ldrsb.w r8, [r14, #226]
    ldrsb.w r11, [r14, #442]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #256]
    str.w r5, [r0, #1120]
    str.w r6, [r0, #1984]
    str.w r7, [r0, #2848]
    str.w r8, [r1, #256]
    str.w r9, [r1, #1120]
    str.w r10, [r1, #1984]
    str.w r11, [r1, #2848]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #578]
    ldrsb.w r6, [r14, #146]
    ldrsb.w r7, [r14, #794]
    ldrsb.w r9, [r14, #362]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #260]
    str.w r5, [r0, #1124]
    str.w r6, [r0, #1988]
    str.w r7, [r0, #2852]
    str.w r8, [r1, #260]
    str.w r9, [r1, #1124]
    str.w r10, [r1, #1988]
    str.w r11, [r1, #2852]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #66]
    ldrsb.w r5, [r14, #714]
    ldrsb.w r7, [r14, #282]
    ldrsb.w r10, [r14, #498]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #264]
    str.w r5, [r0, #1128]
    str.w r6, [r0, #1992]
    str.w r7, [r0, #2856]
    str.w r8, [r1, #264]
    str.w r9, [r1, #1128]
    str.w r10, [r1, #1992]
    str.w r11, [r1, #2856]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #202]
    ldrsb.w r6, [r14, #850]
    ldrsb.w r8, [r14, #418]
    ldrsb.w r11, [r14, #634]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #268]
    str.w r5, [r0, #1132]
    str.w r6, [r0, #1996]
    str.w r7, [r0, #2860]
    str.w r8, [r1, #268]
    str.w r9, [r1, #1132]
    str.w r10, [r1, #1996]
    str.w r11, [r1, #2860]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #770]
    ldrsb.w r6, [r14, #338]
    ldrsb.w r9, [r14, #554]
    ldrsb.w r11, [r14, #122]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #272]
    str.w r5, [r0, #1136]
    str.w r6, [r0, #2000]
    str.w r7, [r0, #2864]
    str.w r8, [r1, #272]
    str.w r9, [r1, #1136]
    str.w r10, [r1, #2000]
    str.w r11, [r1, #2864]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #258]
    ldrsb.w r7, [r14, #474]
    ldrsb.w r9, [r14, #42]
    ldrsb.w r10, [r14, #690]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #276]
    str.w r5, [r0, #1140]
    str.w r6, [r0, #2004]
    str.w r7, [r0, #2868]
    str.w r8, [r1, #276]
    str.w r9, [r1, #1140]
    str.w r10, [r1, #2004]
    str.w r11, [r1, #2868]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #394]
    ldrsb.w r8, [r14, #610]
    ldrsb.w r10, [r14, #178]
    ldrsb.w r11, [r14, #826]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #280]
    str.w r5, [r0, #1144]
    str.w r6, [r0, #2008]
    str.w r7, [r0, #2872]
    str.w r8, [r1, #280]
    str.w r9, [r1, #1144]
    str.w r10, [r1, #2008]
    str.w r11, [r1, #2872]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #530]
    ldrsb.w r8, [r14, #98]
    ldrsb.w r9, [r14, #746]
    ldrsb.w r11, [r14, #314]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #284]
    str.w r5, [r0, #1148]
    str.w r6, [r0, #2012]
    str.w r7, [r0, #2876]
    str.w r8, [r1, #284]
    str.w r9, [r1, #1148]
    str.w r10, [r1, #2012]
    str.w r11, [r1, #2876]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #450]
    ldrsb.w r6, [r14, #18]
    ldrsb.w r7, [r14, #666]
    ldrsb.w r9, [r14, #234]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #288]
    str.w r5, [r0, #1152]
    str.w r6, [r0, #2016]
    str.w r7, [r0, #2880]
    str.w r8, [r1, #288]
    str.w r9, [r1, #1152]
    str.w r10, [r1, #2016]
    str.w r11, [r1, #2880]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #586]
    ldrsb.w r7, [r14, #154]
    ldrsb.w r8, [r14, #802]
    ldrsb.w r10, [r14, #370]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #292]
    str.w r5, [r0, #1156]
    str.w r6, [r0, #2020]
    str.w r7, [r0, #2884]
    str.w r8, [r1, #292]
    str.w r9, [r1, #1156]
    str.w r10, [r1, #2020]
    str.w r11, [r1, #2884]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #74]
    ldrsb.w r6, [r14, #722]
    ldrsb.w r8, [r14, #290]
    ldrsb.w r11, [r14, #506]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #296]
    str.w r5, [r0, #1160]
    str.w r6, [r0, #2024]
    str.w r7, [r0, #2888]
    str.w r8, [r1, #296]
    str.w r9, [r1, #1160]
    str.w r10, [r1, #2024]
    str.w r11, [r1, #2888]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #642]
    ldrsb.w r6, [r14, #210]
    ldrsb.w r9, [r14, #426]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #300]
    str.w r5, [r0, #1164]
    str.w r6, [r0, #2028]
    str.w r7, [r0, #2892]
    str.w r8, [r1, #300]
    str.w r9, [r1, #1164]
    str.w r10, [r1, #2028]
    str.w r11, [r1, #2892]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #130]
    ldrsb.w r5, [r14, #778]
    ldrsb.w r7, [r14, #346]
    ldrsb.w r10, [r14, #562]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #304]
    str.w r5, [r0, #1168]
    str.w r6, [r0, #2032]
    str.w r7, [r0, #2896]
    str.w r8, [r1, #304]
    str.w r9, [r1, #1168]
    str.w r10, [r1, #2032]
    str.w r11, [r1, #2896]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #266]
    ldrsb.w r8, [r14, #482]
    ldrsb.w r10, [r14, #50]
    ldrsb.w r11, [r14, #698]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #308]
    str.w r5, [r0, #1172]
    str.w r6, [r0, #2036]
    str.w r7, [r0, #2900]
    str.w r8, [r1, #308]
    str.w r9, [r1, #1172]
    str.w r10, [r1, #2036]
    str.w r11, [r1, #2900]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #834]
    ldrsb.w r6, [r14, #402]
    ldrsb.w r9, [r14, #618]
    ldrsb.w r11, [r14, #186]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #312]
    str.w r5, [r0, #1176]
    str.w r6, [r0, #2040]
    str.w r7, [r0, #2904]
    str.w r8, [r1, #312]
    str.w r9, [r1, #1176]
    str.w r10, [r1, #2040]
    str.w r11, [r1, #2904]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #322]
    ldrsb.w r7, [r14, #538]
    ldrsb.w r9, [r14, #106]
    ldrsb.w r10, [r14, #754]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #316]
    str.w r5, [r0, #1180]
    str.w r6, [r0, #2044]
    str.w r7, [r0, #2908]
    str.w r8, [r1, #316]
    str.w r9, [r1, #1180]
    str.w r10, [r1, #2044]
    str.w r11, [r1, #2908]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #458]
    ldrsb.w r7, [r14, #26]
    ldrsb.w r8, [r14, #674]
    ldrsb.w r10, [r14, #242]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #320]
    str.w r5, [r0, #1184]
    str.w r6, [r0, #2048]
    str.w r7, [r0, #2912]
    str.w r8, [r1, #320]
    str.w r9, [r1, #1184]
    str.w r10, [r1, #2048]
    str.w r11, [r1, #2912]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #459]
    ldrsb.w r7, [r14, #27]
    ldrsb.w r8, [r14, #675]
    ldrsb.w r10, [r14, #243]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #324]
    str.w r5, [r0, #1188]
    str.w r6, [r0, #2052]
    str.w r7, [r0, #2916]
    str.w r8, [r1, #324]
    str.w r9, [r1, #1188]
    str.w r10, [r1, #2052]
    str.w r11, [r1, #2916]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #595]
    ldrsb.w r8, [r14, #163]
    ldrsb.w r9, [r14, #811]
    ldrsb.w r11, [r14, #379]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #328]
    str.w r5, [r0, #1192]
    str.w r6, [r0, #2056]
    str.w r7, [r0, #2920]
    str.w r8, [r1, #328]
    str.w r9, [r1, #1192]
    str.w r10, [r1, #2056]
    str.w r11, [r1, #2920]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #515]
    ldrsb.w r6, [r14, #83]
    ldrsb.w r7, [r14, #731]
    ldrsb.w r9, [r14, #299]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #332]
    str.w r5, [r0, #1196]
    str.w r6, [r0, #2060]
    str.w r7, [r0, #2924]
    str.w r8, [r1, #332]
    str.w r9, [r1, #1196]
    str.w r10, [r1, #2060]
    str.w r11, [r1, #2924]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #3]
    ldrsb.w r5, [r14, #651]
    ldrsb.w r7, [r14, #219]
    ldrsb.w r10, [r14, #435]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #336]
    str.w r5, [r0, #1200]
    str.w r6, [r0, #2064]
    str.w r7, [r0, #2928]
    str.w r8, [r1, #336]
    str.w r9, [r1, #1200]
    str.w r10, [r1, #2064]
    str.w r11, [r1, #2928]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #139]
    ldrsb.w r6, [r14, #787]
    ldrsb.w r8, [r14, #355]
    ldrsb.w r11, [r14, #571]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #340]
    str.w r5, [r0, #1204]
    str.w r6, [r0, #2068]
    str.w r7, [r0, #2932]
    str.w r8, [r1, #340]
    str.w r9, [r1, #1204]
    str.w r10, [r1, #2068]
    str.w r11, [r1, #2932]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #707]
    ldrsb.w r6, [r14, #275]
    ldrsb.w r9, [r14, #491]
    ldrsb.w r11, [r14, #59]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #344]
    str.w r5, [r0, #1208]
    str.w r6, [r0, #2072]
    str.w r7, [r0, #2936]
    str.w r8, [r1, #344]
    str.w r9, [r1, #1208]
    str.w r10, [r1, #2072]
    str.w r11, [r1, #2936]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #195]
    ldrsb.w r5, [r14, #843]
    ldrsb.w r7, [r14, #411]
    ldrsb.w r10, [r14, #627]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #348]
    str.w r5, [r0, #1212]
    str.w r6, [r0, #2076]
    str.w r7, [r0, #2940]
    str.w r8, [r1, #348]
    str.w r9, [r1, #1212]
    str.w r10, [r1, #2076]
    str.w r11, [r1, #2940]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #331]
    ldrsb.w r8, [r14, #547]
    ldrsb.w r10, [r14, #115]
    ldrsb.w r11, [r14, #763]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #352]
    str.w r5, [r0, #1216]
    str.w r6, [r0, #2080]
    str.w r7, [r0, #2944]
    str.w r8, [r1, #352]
    str.w r9, [r1, #1216]
    str.w r10, [r1, #2080]
    str.w r11, [r1, #2944]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #467]
    ldrsb.w r8, [r14, #35]
    ldrsb.w r9, [r14, #683]
    ldrsb.w r11, [r14, #251]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #356]
    str.w r5, [r0, #1220]
    str.w r6, [r0, #2084]
    str.w r7, [r0, #2948]
    str.w r8, [r1, #356]
    str.w r9, [r1, #1220]
    str.w r10, [r1, #2084]
    str.w r11, [r1, #2948]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #387]
    ldrsb.w r7, [r14, #603]
    ldrsb.w r9, [r14, #171]
    ldrsb.w r10, [r14, #819]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #360]
    str.w r5, [r0, #1224]
    str.w r6, [r0, #2088]
    str.w r7, [r0, #2952]
    str.w r8, [r1, #360]
    str.w r9, [r1, #1224]
    str.w r10, [r1, #2088]
    str.w r11, [r1, #2952]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #523]
    ldrsb.w r7, [r14, #91]
    ldrsb.w r8, [r14, #739]
    ldrsb.w r10, [r14, #307]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #364]
    str.w r5, [r0, #1228]
    str.w r6, [r0, #2092]
    str.w r7, [r0, #2956]
    str.w r8, [r1, #364]
    str.w r9, [r1, #1228]
    str.w r10, [r1, #2092]
    str.w r11, [r1, #2956]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #11]
    ldrsb.w r6, [r14, #659]
    ldrsb.w r8, [r14, #227]
    ldrsb.w r11, [r14, #443]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #368]
    str.w r5, [r0, #1232]
    str.w r6, [r0, #2096]
    str.w r7, [r0, #2960]
    str.w r8, [r1, #368]
    str.w r9, [r1, #1232]
    str.w r10, [r1, #2096]
    str.w r11, [r1, #2960]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #579]
    ldrsb.w r6, [r14, #147]
    ldrsb.w r7, [r14, #795]
    ldrsb.w r9, [r14, #363]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #372]
    str.w r5, [r0, #1236]
    str.w r6, [r0, #2100]
    str.w r7, [r0, #2964]
    str.w r8, [r1, #372]
    str.w r9, [r1, #1236]
    str.w r10, [r1, #2100]
    str.w r11, [r1, #2964]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #67]
    ldrsb.w r5, [r14, #715]
    ldrsb.w r7, [r14, #283]
    ldrsb.w r10, [r14, #499]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #376]
    str.w r5, [r0, #1240]
    str.w r6, [r0, #2104]
    str.w r7, [r0, #2968]
    str.w r8, [r1, #376]
    str.w r9, [r1, #1240]
    str.w r10, [r1, #2104]
    str.w r11, [r1, #2968]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #203]
    ldrsb.w r6, [r14, #851]
    ldrsb.w r8, [r14, #419]
    ldrsb.w r11, [r14, #635]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #380]
    str.w r5, [r0, #1244]
    str.w r6, [r0, #2108]
    str.w r7, [r0, #2972]
    str.w r8, [r1, #380]
    str.w r9, [r1, #1244]
    str.w r10, [r1, #2108]
    str.w r11, [r1, #2972]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #771]
    ldrsb.w r6, [r14, #339]
    ldrsb.w r9, [r14, #555]
    ldrsb.w r11, [r14, #123]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #384]
    str.w r5, [r0, #1248]
    str.w r6, [r0, #2112]
    str.w r7, [r0, #2976]
    str.w r8, [r1, #384]
    str.w r9, [r1, #1248]
    str.w r10, [r1, #2112]
    str.w r11, [r1, #2976]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #259]
    ldrsb.w r7, [r14, #475]
    ldrsb.w r9, [r14, #43]
    ldrsb.w r10, [r14, #691]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #388]
    str.w r5, [r0, #1252]
    str.w r6, [r0, #2116]
    str.w r7, [r0, #2980]
    str.w r8, [r1, #388]
    str.w r9, [r1, #1252]
    str.w r10, [r1, #2116]
    str.w r11, [r1, #2980]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #395]
    ldrsb.w r8, [r14, #611]
    ldrsb.w r10, [r14, #179]
    ldrsb.w r11, [r14, #827]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #392]
    str.w r5, [r0, #1256]
    str.w r6, [r0, #2120]
    str.w r7, [r0, #2984]
    str.w r8, [r1, #392]
    str.w r9, [r1, #1256]
    str.w r10, [r1, #2120]
    str.w r11, [r1, #2984]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #531]
    ldrsb.w r8, [r14, #99]
    ldrsb.w r9, [r14, #747]
    ldrsb.w r11, [r14, #315]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #396]
    str.w r5, [r0, #1260]
    str.w r6, [r0, #2124]
    str.w r7, [r0, #2988]
    str.w r8, [r1, #396]
    str.w r9, [r1, #1260]
    str.w r10, [r1, #2124]
    str.w r11, [r1, #2988]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #451]
    ldrsb.w r6, [r14, #19]
    ldrsb.w r7, [r14, #667]
    ldrsb.w r9, [r14, #235]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #400]
    str.w r5, [r0, #1264]
    str.w r6, [r0, #2128]
    str.w r7, [r0, #2992]
    str.w r8, [r1, #400]
    str.w r9, [r1, #1264]
    str.w r10, [r1, #2128]
    str.w r11, [r1, #2992]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #587]
    ldrsb.w r7, [r14, #155]
    ldrsb.w r8, [r14, #803]
    ldrsb.w r10, [r14, #371]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #404]
    str.w r5, [r0, #1268]
    str.w r6, [r0, #2132]
    str.w r7, [r0, #2996]
    str.w r8, [r1, #404]
    str.w r9, [r1, #1268]
    str.w r10, [r1, #2132]
    str.w r11, [r1, #2996]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #75]
    ldrsb.w r6, [r14, #723]
    ldrsb.w r8, [r14, #291]
    ldrsb.w r11, [r14, #507]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #408]
    str.w r5, [r0, #1272]
    str.w r6, [r0, #2136]
    str.w r7, [r0, #3000]
    str.w r8, [r1, #408]
    str.w r9, [r1, #1272]
    str.w r10, [r1, #2136]
    str.w r11, [r1, #3000]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #643]
    ldrsb.w r6, [r14, #211]
    ldrsb.w r9, [r14, #427]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #412]
    str.w r5, [r0, #1276]
    str.w r6, [r0, #2140]
    str.w r7, [r0, #3004]
    str.w r8, [r1, #412]
    str.w r9, [r1, #1276]
    str.w r10, [r1, #2140]
    str.w r11, [r1, #3004]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #131]
    ldrsb.w r5, [r14, #779]
    ldrsb.w r7, [r14, #347]
    ldrsb.w r10, [r14, #563]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #416]
    str.w r5, [r0, #1280]
    str.w r6, [r0, #2144]
    str.w r7, [r0, #3008]
    str.w r8, [r1, #416]
    str.w r9, [r1, #1280]
    str.w r10, [r1, #2144]
    str.w r11, [r1, #3008]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #267]
    ldrsb.w r8, [r14, #483]
    ldrsb.w r10, [r14, #51]
    ldrsb.w r11, [r14, #699]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #420]
    str.w r5, [r0, #1284]
    str.w r6, [r0, #2148]
    str.w r7, [r0, #3012]
    str.w r8, [r1, #420]
    str.w r9, [r1, #1284]
    str.w r10, [r1, #2148]
    str.w r11, [r1, #3012]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #835]
    ldrsb.w r6, [r14, #403]
    ldrsb.w r9, [r14, #619]
    ldrsb.w r11, [r14, #187]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #424]
    str.w r5, [r0, #1288]
    str.w r6, [r0, #2152]
    str.w r7, [r0, #3016]
    str.w r8, [r1, #424]
    str.w r9, [r1, #1288]
    str.w r10, [r1, #2152]
    str.w r11, [r1, #3016]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #323]
    ldrsb.w r7, [r14, #539]
    ldrsb.w r9, [r14, #107]
    ldrsb.w r10, [r14, #755]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #428]
    str.w r5, [r0, #1292]
    str.w r6, [r0, #2156]
    str.w r7, [r0, #3020]
    str.w r8, [r1, #428]
    str.w r9, [r1, #1292]
    str.w r10, [r1, #2156]
    str.w r11, [r1, #3020]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #324]
    ldrsb.w r7, [r14, #540]
    ldrsb.w r9, [r14, #108]
    ldrsb.w r10, [r14, #756]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #432]
    str.w r5, [r0, #1296]
    str.w r6, [r0, #2160]
    str.w r7, [r0, #3024]
    str.w r8, [r1, #432]
    str.w r9, [r1, #1296]
    str.w r10, [r1, #2160]
    str.w r11, [r1, #3024]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #460]
    ldrsb.w r7, [r14, #28]
    ldrsb.w r8, [r14, #676]
    ldrsb.w r10, [r14, #244]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #436]
    str.w r5, [r0, #1300]
    str.w r6, [r0, #2164]
    str.w r7, [r0, #3028]
    str.w r8, [r1, #436]
    str.w r9, [r1, #1300]
    str.w r10, [r1, #2164]
    str.w r11, [r1, #3028]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #596]
    ldrsb.w r8, [r14, #164]
    ldrsb.w r9, [r14, #812]
    ldrsb.w r11, [r14, #380]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #440]
    str.w r5, [r0, #1304]
    str.w r6, [r0, #2168]
    str.w r7, [r0, #3032]
    str.w r8, [r1, #440]
    str.w r9, [r1, #1304]
    str.w r10, [r1, #2168]
    str.w r11, [r1, #3032]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #516]
    ldrsb.w r6, [r14, #84]
    ldrsb.w r7, [r14, #732]
    ldrsb.w r9, [r14, #300]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #444]
    str.w r5, [r0, #1308]
    str.w r6, [r0, #2172]
    str.w r7, [r0, #3036]
    str.w r8, [r1, #444]
    str.w r9, [r1, #1308]
    str.w r10, [r1, #2172]
    str.w r11, [r1, #3036]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #4]
    ldrsb.w r5, [r14, #652]
    ldrsb.w r7, [r14, #220]
    ldrsb.w r10, [r14, #436]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #448]
    str.w r5, [r0, #1312]
    str.w r6, [r0, #2176]
    str.w r7, [r0, #3040]
    str.w r8, [r1, #448]
    str.w r9, [r1, #1312]
    str.w r10, [r1, #2176]
    str.w r11, [r1, #3040]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #140]
    ldrsb.w r6, [r14, #788]
    ldrsb.w r8, [r14, #356]
    ldrsb.w r11, [r14, #572]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #452]
    str.w r5, [r0, #1316]
    str.w r6, [r0, #2180]
    str.w r7, [r0, #3044]
    str.w r8, [r1, #452]
    str.w r9, [r1, #1316]
    str.w r10, [r1, #2180]
    str.w r11, [r1, #3044]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #708]
    ldrsb.w r6, [r14, #276]
    ldrsb.w r9, [r14, #492]
    ldrsb.w r11, [r14, #60]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #456]
    str.w r5, [r0, #1320]
    str.w r6, [r0, #2184]
    str.w r7, [r0, #3048]
    str.w r8, [r1, #456]
    str.w r9, [r1, #1320]
    str.w r10, [r1, #2184]
    str.w r11, [r1, #3048]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #196]
    ldrsb.w r5, [r14, #844]
    ldrsb.w r7, [r14, #412]
    ldrsb.w r10, [r14, #628]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #460]
    str.w r5, [r0, #1324]
    str.w r6, [r0, #2188]
    str.w r7, [r0, #3052]
    str.w r8, [r1, #460]
    str.w r9, [r1, #1324]
    str.w r10, [r1, #2188]
    str.w r11, [r1, #3052]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #332]
    ldrsb.w r8, [r14, #548]
    ldrsb.w r10, [r14, #116]
    ldrsb.w r11, [r14, #764]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #464]
    str.w r5, [r0, #1328]
    str.w r6, [r0, #2192]
    str.w r7, [r0, #3056]
    str.w r8, [r1, #464]
    str.w r9, [r1, #1328]
    str.w r10, [r1, #2192]
    str.w r11, [r1, #3056]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #468]
    ldrsb.w r8, [r14, #36]
    ldrsb.w r9, [r14, #684]
    ldrsb.w r11, [r14, #252]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #468]
    str.w r5, [r0, #1332]
    str.w r6, [r0, #2196]
    str.w r7, [r0, #3060]
    str.w r8, [r1, #468]
    str.w r9, [r1, #1332]
    str.w r10, [r1, #2196]
    str.w r11, [r1, #3060]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #388]
    ldrsb.w r7, [r14, #604]
    ldrsb.w r9, [r14, #172]
    ldrsb.w r10, [r14, #820]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #472]
    str.w r5, [r0, #1336]
    str.w r6, [r0, #2200]
    str.w r7, [r0, #3064]
    str.w r8, [r1, #472]
    str.w r9, [r1, #1336]
    str.w r10, [r1, #2200]
    str.w r11, [r1, #3064]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #524]
    ldrsb.w r7, [r14, #92]
    ldrsb.w r8, [r14, #740]
    ldrsb.w r10, [r14, #308]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #476]
    str.w r5, [r0, #1340]
    str.w r6, [r0, #2204]
    str.w r7, [r0, #3068]
    str.w r8, [r1, #476]
    str.w r9, [r1, #1340]
    str.w r10, [r1, #2204]
    str.w r11, [r1, #3068]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #12]
    ldrsb.w r6, [r14, #660]
    ldrsb.w r8, [r14, #228]
    ldrsb.w r11, [r14, #444]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #480]
    str.w r5, [r0, #1344]
    str.w r6, [r0, #2208]
    str.w r7, [r0, #3072]
    str.w r8, [r1, #480]
    str.w r9, [r1, #1344]
    str.w r10, [r1, #2208]
    str.w r11, [r1, #3072]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #580]
    ldrsb.w r6, [r14, #148]
    ldrsb.w r7, [r14, #796]
    ldrsb.w r9, [r14, #364]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #484]
    str.w r5, [r0, #1348]
    str.w r6, [r0, #2212]
    str.w r7, [r0, #3076]
    str.w r8, [r1, #484]
    str.w r9, [r1, #1348]
    str.w r10, [r1, #2212]
    str.w r11, [r1, #3076]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #68]
    ldrsb.w r5, [r14, #716]
    ldrsb.w r7, [r14, #284]
    ldrsb.w r10, [r14, #500]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #488]
    str.w r5, [r0, #1352]
    str.w r6, [r0, #2216]
    str.w r7, [r0, #3080]
    str.w r8, [r1, #488]
    str.w r9, [r1, #1352]
    str.w r10, [r1, #2216]
    str.w r11, [r1, #3080]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #204]
    ldrsb.w r6, [r14, #852]
    ldrsb.w r8, [r14, #420]
    ldrsb.w r11, [r14, #636]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #492]
    str.w r5, [r0, #1356]
    str.w r6, [r0, #2220]
    str.w r7, [r0, #3084]
    str.w r8, [r1, #492]
    str.w r9, [r1, #1356]
    str.w r10, [r1, #2220]
    str.w r11, [r1, #3084]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #772]
    ldrsb.w r6, [r14, #340]
    ldrsb.w r9, [r14, #556]
    ldrsb.w r11, [r14, #124]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #496]
    str.w r5, [r0, #1360]
    str.w r6, [r0, #2224]
    str.w r7, [r0, #3088]
    str.w r8, [r1, #496]
    str.w r9, [r1, #1360]
    str.w r10, [r1, #2224]
    str.w r11, [r1, #3088]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #260]
    ldrsb.w r7, [r14, #476]
    ldrsb.w r9, [r14, #44]
    ldrsb.w r10, [r14, #692]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #500]
    str.w r5, [r0, #1364]
    str.w r6, [r0, #2228]
    str.w r7, [r0, #3092]
    str.w r8, [r1, #500]
    str.w r9, [r1, #1364]
    str.w r10, [r1, #2228]
    str.w r11, [r1, #3092]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #396]
    ldrsb.w r8, [r14, #612]
    ldrsb.w r10, [r14, #180]
    ldrsb.w r11, [r14, #828]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #504]
    str.w r5, [r0, #1368]
    str.w r6, [r0, #2232]
    str.w r7, [r0, #3096]
    str.w r8, [r1, #504]
    str.w r9, [r1, #1368]
    str.w r10, [r1, #2232]
    str.w r11, [r1, #3096]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #532]
    ldrsb.w r8, [r14, #100]
    ldrsb.w r9, [r14, #748]
    ldrsb.w r11, [r14, #316]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #508]
    str.w r5, [r0, #1372]
    str.w r6, [r0, #2236]
    str.w r7, [r0, #3100]
    str.w r8, [r1, #508]
    str.w r9, [r1, #1372]
    str.w r10, [r1, #2236]
    str.w r11, [r1, #3100]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #452]
    ldrsb.w r6, [r14, #20]
    ldrsb.w r7, [r14, #668]
    ldrsb.w r9, [r14, #236]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #512]
    str.w r5, [r0, #1376]
    str.w r6, [r0, #2240]
    str.w r7, [r0, #3104]
    str.w r8, [r1, #512]
    str.w r9, [r1, #1376]
    str.w r10, [r1, #2240]
    str.w r11, [r1, #3104]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #588]
    ldrsb.w r7, [r14, #156]
    ldrsb.w r8, [r14, #804]
    ldrsb.w r10, [r14, #372]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #516]
    str.w r5, [r0, #1380]
    str.w r6, [r0, #2244]
    str.w r7, [r0, #3108]
    str.w r8, [r1, #516]
    str.w r9, [r1, #1380]
    str.w r10, [r1, #2244]
    str.w r11, [r1, #3108]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #76]
    ldrsb.w r6, [r14, #724]
    ldrsb.w r8, [r14, #292]
    ldrsb.w r11, [r14, #508]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #520]
    str.w r5, [r0, #1384]
    str.w r6, [r0, #2248]
    str.w r7, [r0, #3112]
    str.w r8, [r1, #520]
    str.w r9, [r1, #1384]
    str.w r10, [r1, #2248]
    str.w r11, [r1, #3112]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #644]
    ldrsb.w r6, [r14, #212]
    ldrsb.w r9, [r14, #428]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #524]
    str.w r5, [r0, #1388]
    str.w r6, [r0, #2252]
    str.w r7, [r0, #3116]
    str.w r8, [r1, #524]
    str.w r9, [r1, #1388]
    str.w r10, [r1, #2252]
    str.w r11, [r1, #3116]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #132]
    ldrsb.w r5, [r14, #780]
    ldrsb.w r7, [r14, #348]
    ldrsb.w r10, [r14, #564]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #528]
    str.w r5, [r0, #1392]
    str.w r6, [r0, #2256]
    str.w r7, [r0, #3120]
    str.w r8, [r1, #528]
    str.w r9, [r1, #1392]
    str.w r10, [r1, #2256]
    str.w r11, [r1, #3120]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #268]
    ldrsb.w r8, [r14, #484]
    ldrsb.w r10, [r14, #52]
    ldrsb.w r11, [r14, #700]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #532]
    str.w r5, [r0, #1396]
    str.w r6, [r0, #2260]
    str.w r7, [r0, #3124]
    str.w r8, [r1, #532]
    str.w r9, [r1, #1396]
    str.w r10, [r1, #2260]
    str.w r11, [r1, #3124]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #836]
    ldrsb.w r6, [r14, #404]
    ldrsb.w r9, [r14, #620]
    ldrsb.w r11, [r14, #188]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #536]
    str.w r5, [r0, #1400]
    str.w r6, [r0, #2264]
    str.w r7, [r0, #3128]
    str.w r8, [r1, #536]
    str.w r9, [r1, #1400]
    str.w r10, [r1, #2264]
    str.w r11, [r1, #3128]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #837]
    ldrsb.w r6, [r14, #405]
    ldrsb.w r9, [r14, #621]
    ldrsb.w r11, [r14, #189]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #540]
    str.w r5, [r0, #1404]
    str.w r6, [r0, #2268]
    str.w r7, [r0, #3132]
    str.w r8, [r1, #540]
    str.w r9, [r1, #1404]
    str.w r10, [r1, #2268]
    str.w r11, [r1, #3132]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #325]
    ldrsb.w r7, [r14, #541]
    ldrsb.w r9, [r14, #109]
    ldrsb.w r10, [r14, #757]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #544]
    str.w r5, [r0, #1408]
    str.w r6, [r0, #2272]
    str.w r7, [r0, #3136]
    str.w r8, [r1, #544]
    str.w r9, [r1, #1408]
    str.w r10, [r1, #2272]
    str.w r11, [r1, #3136]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #461]
    ldrsb.w r7, [r14, #29]
    ldrsb.w r8, [r14, #677]
    ldrsb.w r10, [r14, #245]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #548]
    str.w r5, [r0, #1412]
    str.w r6, [r0, #2276]
    str.w r7, [r0, #3140]
    str.w r8, [r1, #548]
    str.w r9, [r1, #1412]
    str.w r10, [r1, #2276]
    str.w r11, [r1, #3140]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #597]
    ldrsb.w r8, [r14, #165]
    ldrsb.w r9, [r14, #813]
    ldrsb.w r11, [r14, #381]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #552]
    str.w r5, [r0, #1416]
    str.w r6, [r0, #2280]
    str.w r7, [r0, #3144]
    str.w r8, [r1, #552]
    str.w r9, [r1, #1416]
    str.w r10, [r1, #2280]
    str.w r11, [r1, #3144]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #517]
    ldrsb.w r6, [r14, #85]
    ldrsb.w r7, [r14, #733]
    ldrsb.w r9, [r14, #301]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #556]
    str.w r5, [r0, #1420]
    str.w r6, [r0, #2284]
    str.w r7, [r0, #3148]
    str.w r8, [r1, #556]
    str.w r9, [r1, #1420]
    str.w r10, [r1, #2284]
    str.w r11, [r1, #3148]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #5]
    ldrsb.w r5, [r14, #653]
    ldrsb.w r7, [r14, #221]
    ldrsb.w r10, [r14, #437]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #560]
    str.w r5, [r0, #1424]
    str.w r6, [r0, #2288]
    str.w r7, [r0, #3152]
    str.w r8, [r1, #560]
    str.w r9, [r1, #1424]
    str.w r10, [r1, #2288]
    str.w r11, [r1, #3152]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #141]
    ldrsb.w r6, [r14, #789]
    ldrsb.w r8, [r14, #357]
    ldrsb.w r11, [r14, #573]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #564]
    str.w r5, [r0, #1428]
    str.w r6, [r0, #2292]
    str.w r7, [r0, #3156]
    str.w r8, [r1, #564]
    str.w r9, [r1, #1428]
    str.w r10, [r1, #2292]
    str.w r11, [r1, #3156]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #709]
    ldrsb.w r6, [r14, #277]
    ldrsb.w r9, [r14, #493]
    ldrsb.w r11, [r14, #61]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #568]
    str.w r5, [r0, #1432]
    str.w r6, [r0, #2296]
    str.w r7, [r0, #3160]
    str.w r8, [r1, #568]
    str.w r9, [r1, #1432]
    str.w r10, [r1, #2296]
    str.w r11, [r1, #3160]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #197]
    ldrsb.w r5, [r14, #845]
    ldrsb.w r7, [r14, #413]
    ldrsb.w r10, [r14, #629]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #572]
    str.w r5, [r0, #1436]
    str.w r6, [r0, #2300]
    str.w r7, [r0, #3164]
    str.w r8, [r1, #572]
    str.w r9, [r1, #1436]
    str.w r10, [r1, #2300]
    str.w r11, [r1, #3164]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #333]
    ldrsb.w r8, [r14, #549]
    ldrsb.w r10, [r14, #117]
    ldrsb.w r11, [r14, #765]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #576]
    str.w r5, [r0, #1440]
    str.w r6, [r0, #2304]
    str.w r7, [r0, #3168]
    str.w r8, [r1, #576]
    str.w r9, [r1, #1440]
    str.w r10, [r1, #2304]
    str.w r11, [r1, #3168]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #469]
    ldrsb.w r8, [r14, #37]
    ldrsb.w r9, [r14, #685]
    ldrsb.w r11, [r14, #253]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #580]
    str.w r5, [r0, #1444]
    str.w r6, [r0, #2308]
    str.w r7, [r0, #3172]
    str.w r8, [r1, #580]
    str.w r9, [r1, #1444]
    str.w r10, [r1, #2308]
    str.w r11, [r1, #3172]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #389]
    ldrsb.w r7, [r14, #605]
    ldrsb.w r9, [r14, #173]
    ldrsb.w r10, [r14, #821]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #584]
    str.w r5, [r0, #1448]
    str.w r6, [r0, #2312]
    str.w r7, [r0, #3176]
    str.w r8, [r1, #584]
    str.w r9, [r1, #1448]
    str.w r10, [r1, #2312]
    str.w r11, [r1, #3176]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #525]
    ldrsb.w r7, [r14, #93]
    ldrsb.w r8, [r14, #741]
    ldrsb.w r10, [r14, #309]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #588]
    str.w r5, [r0, #1452]
    str.w r6, [r0, #2316]
    str.w r7, [r0, #3180]
    str.w r8, [r1, #588]
    str.w r9, [r1, #1452]
    str.w r10, [r1, #2316]
    str.w r11, [r1, #3180]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #13]
    ldrsb.w r6, [r14, #661]
    ldrsb.w r8, [r14, #229]
    ldrsb.w r11, [r14, #445]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #592]
    str.w r5, [r0, #1456]
    str.w r6, [r0, #2320]
    str.w r7, [r0, #3184]
    str.w r8, [r1, #592]
    str.w r9, [r1, #1456]
    str.w r10, [r1, #2320]
    str.w r11, [r1, #3184]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #581]
    ldrsb.w r6, [r14, #149]
    ldrsb.w r7, [r14, #797]
    ldrsb.w r9, [r14, #365]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #596]
    str.w r5, [r0, #1460]
    str.w r6, [r0, #2324]
    str.w r7, [r0, #3188]
    str.w r8, [r1, #596]
    str.w r9, [r1, #1460]
    str.w r10, [r1, #2324]
    str.w r11, [r1, #3188]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #69]
    ldrsb.w r5, [r14, #717]
    ldrsb.w r7, [r14, #285]
    ldrsb.w r10, [r14, #501]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #600]
    str.w r5, [r0, #1464]
    str.w r6, [r0, #2328]
    str.w r7, [r0, #3192]
    str.w r8, [r1, #600]
    str.w r9, [r1, #1464]
    str.w r10, [r1, #2328]
    str.w r11, [r1, #3192]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #205]
    ldrsb.w r6, [r14, #853]
    ldrsb.w r8, [r14, #421]
    ldrsb.w r11, [r14, #637]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #604]
    str.w r5, [r0, #1468]
    str.w r6, [r0, #2332]
    str.w r7, [r0, #3196]
    str.w r8, [r1, #604]
    str.w r9, [r1, #1468]
    str.w r10, [r1, #2332]
    str.w r11, [r1, #3196]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #773]
    ldrsb.w r6, [r14, #341]
    ldrsb.w r9, [r14, #557]
    ldrsb.w r11, [r14, #125]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #608]
    str.w r5, [r0, #1472]
    str.w r6, [r0, #2336]
    str.w r7, [r0, #3200]
    str.w r8, [r1, #608]
    str.w r9, [r1, #1472]
    str.w r10, [r1, #2336]
    str.w r11, [r1, #3200]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #261]
    ldrsb.w r7, [r14, #477]
    ldrsb.w r9, [r14, #45]
    ldrsb.w r10, [r14, #693]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #612]
    str.w r5, [r0, #1476]
    str.w r6, [r0, #2340]
    str.w r7, [r0, #3204]
    str.w r8, [r1, #612]
    str.w r9, [r1, #1476]
    str.w r10, [r1, #2340]
    str.w r11, [r1, #3204]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #397]
    ldrsb.w r8, [r14, #613]
    ldrsb.w r10, [r14, #181]
    ldrsb.w r11, [r14, #829]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #616]
    str.w r5, [r0, #1480]
    str.w r6, [r0, #2344]
    str.w r7, [r0, #3208]
    str.w r8, [r1, #616]
    str.w r9, [r1, #1480]
    str.w r10, [r1, #2344]
    str.w r11, [r1, #3208]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #533]
    ldrsb.w r8, [r14, #101]
    ldrsb.w r9, [r14, #749]
    ldrsb.w r11, [r14, #317]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #620]
    str.w r5, [r0, #1484]
    str.w r6, [r0, #2348]
    str.w r7, [r0, #3212]
    str.w r8, [r1, #620]
    str.w r9, [r1, #1484]
    str.w r10, [r1, #2348]
    str.w r11, [r1, #3212]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #453]
    ldrsb.w r6, [r14, #21]
    ldrsb.w r7, [r14, #669]
    ldrsb.w r9, [r14, #237]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #624]
    str.w r5, [r0, #1488]
    str.w r6, [r0, #2352]
    str.w r7, [r0, #3216]
    str.w r8, [r1, #624]
    str.w r9, [r1, #1488]
    str.w r10, [r1, #2352]
    str.w r11, [r1, #3216]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #589]
    ldrsb.w r7, [r14, #157]
    ldrsb.w r8, [r14, #805]
    ldrsb.w r10, [r14, #373]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #628]
    str.w r5, [r0, #1492]
    str.w r6, [r0, #2356]
    str.w r7, [r0, #3220]
    str.w r8, [r1, #628]
    str.w r9, [r1, #1492]
    str.w r10, [r1, #2356]
    str.w r11, [r1, #3220]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #77]
    ldrsb.w r6, [r14, #725]
    ldrsb.w r8, [r14, #293]
    ldrsb.w r11, [r14, #509]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #632]
    str.w r5, [r0, #1496]
    str.w r6, [r0, #2360]
    str.w r7, [r0, #3224]
    str.w r8, [r1, #632]
    str.w r9, [r1, #1496]
    str.w r10, [r1, #2360]
    str.w r11, [r1, #3224]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #645]
    ldrsb.w r6, [r14, #213]
    ldrsb.w r9, [r14, #429]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #636]
    str.w r5, [r0, #1500]
    str.w r6, [r0, #2364]
    str.w r7, [r0, #3228]
    str.w r8, [r1, #636]
    str.w r9, [r1, #1500]
    str.w r10, [r1, #2364]
    str.w r11, [r1, #3228]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #133]
    ldrsb.w r5, [r14, #781]
    ldrsb.w r7, [r14, #349]
    ldrsb.w r10, [r14, #565]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #640]
    str.w r5, [r0, #1504]
    str.w r6, [r0, #2368]
    str.w r7, [r0, #3232]
    str.w r8, [r1, #640]
    str.w r9, [r1, #1504]
    str.w r10, [r1, #2368]
    str.w r11, [r1, #3232]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #269]
    ldrsb.w r8, [r14, #485]
    ldrsb.w r10, [r14, #53]
    ldrsb.w r11, [r14, #701]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #644]
    str.w r5, [r0, #1508]
    str.w r6, [r0, #2372]
    str.w r7, [r0, #3236]
    str.w r8, [r1, #644]
    str.w r9, [r1, #1508]
    str.w r10, [r1, #2372]
    str.w r11, [r1, #3236]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #270]
    ldrsb.w r8, [r14, #486]
    ldrsb.w r10, [r14, #54]
    ldrsb.w r11, [r14, #702]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #648]
    str.w r5, [r0, #1512]
    str.w r6, [r0, #2376]
    str.w r7, [r0, #3240]
    str.w r8, [r1, #648]
    str.w r9, [r1, #1512]
    str.w r10, [r1, #2376]
    str.w r11, [r1, #3240]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #838]
    ldrsb.w r6, [r14, #406]
    ldrsb.w r9, [r14, #622]
    ldrsb.w r11, [r14, #190]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #652]
    str.w r5, [r0, #1516]
    str.w r6, [r0, #2380]
    str.w r7, [r0, #3244]
    str.w r8, [r1, #652]
    str.w r9, [r1, #1516]
    str.w r10, [r1, #2380]
    str.w r11, [r1, #3244]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #326]
    ldrsb.w r7, [r14, #542]
    ldrsb.w r9, [r14, #110]
    ldrsb.w r10, [r14, #758]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #656]
    str.w r5, [r0, #1520]
    str.w r6, [r0, #2384]
    str.w r7, [r0, #3248]
    str.w r8, [r1, #656]
    str.w r9, [r1, #1520]
    str.w r10, [r1, #2384]
    str.w r11, [r1, #3248]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #462]
    ldrsb.w r7, [r14, #30]
    ldrsb.w r8, [r14, #678]
    ldrsb.w r10, [r14, #246]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #660]
    str.w r5, [r0, #1524]
    str.w r6, [r0, #2388]
    str.w r7, [r0, #3252]
    str.w r8, [r1, #660]
    str.w r9, [r1, #1524]
    str.w r10, [r1, #2388]
    str.w r11, [r1, #3252]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #598]
    ldrsb.w r8, [r14, #166]
    ldrsb.w r9, [r14, #814]
    ldrsb.w r11, [r14, #382]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #664]
    str.w r5, [r0, #1528]
    str.w r6, [r0, #2392]
    str.w r7, [r0, #3256]
    str.w r8, [r1, #664]
    str.w r9, [r1, #1528]
    str.w r10, [r1, #2392]
    str.w r11, [r1, #3256]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #518]
    ldrsb.w r6, [r14, #86]
    ldrsb.w r7, [r14, #734]
    ldrsb.w r9, [r14, #302]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #668]
    str.w r5, [r0, #1532]
    str.w r6, [r0, #2396]
    str.w r7, [r0, #3260]
    str.w r8, [r1, #668]
    str.w r9, [r1, #1532]
    str.w r10, [r1, #2396]
    str.w r11, [r1, #3260]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #6]
    ldrsb.w r5, [r14, #654]
    ldrsb.w r7, [r14, #222]
    ldrsb.w r10, [r14, #438]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #672]
    str.w r5, [r0, #1536]
    str.w r6, [r0, #2400]
    str.w r7, [r0, #3264]
    str.w r8, [r1, #672]
    str.w r9, [r1, #1536]
    str.w r10, [r1, #2400]
    str.w r11, [r1, #3264]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #142]
    ldrsb.w r6, [r14, #790]
    ldrsb.w r8, [r14, #358]
    ldrsb.w r11, [r14, #574]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #676]
    str.w r5, [r0, #1540]
    str.w r6, [r0, #2404]
    str.w r7, [r0, #3268]
    str.w r8, [r1, #676]
    str.w r9, [r1, #1540]
    str.w r10, [r1, #2404]
    str.w r11, [r1, #3268]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #710]
    ldrsb.w r6, [r14, #278]
    ldrsb.w r9, [r14, #494]
    ldrsb.w r11, [r14, #62]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #680]
    str.w r5, [r0, #1544]
    str.w r6, [r0, #2408]
    str.w r7, [r0, #3272]
    str.w r8, [r1, #680]
    str.w r9, [r1, #1544]
    str.w r10, [r1, #2408]
    str.w r11, [r1, #3272]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #198]
    ldrsb.w r5, [r14, #846]
    ldrsb.w r7, [r14, #414]
    ldrsb.w r10, [r14, #630]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #684]
    str.w r5, [r0, #1548]
    str.w r6, [r0, #2412]
    str.w r7, [r0, #3276]
    str.w r8, [r1, #684]
    str.w r9, [r1, #1548]
    str.w r10, [r1, #2412]
    str.w r11, [r1, #3276]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #334]
    ldrsb.w r8, [r14, #550]
    ldrsb.w r10, [r14, #118]
    ldrsb.w r11, [r14, #766]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #688]
    str.w r5, [r0, #1552]
    str.w r6, [r0, #2416]
    str.w r7, [r0, #3280]
    str.w r8, [r1, #688]
    str.w r9, [r1, #1552]
    str.w r10, [r1, #2416]
    str.w r11, [r1, #3280]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #470]
    ldrsb.w r8, [r14, #38]
    ldrsb.w r9, [r14, #686]
    ldrsb.w r11, [r14, #254]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #692]
    str.w r5, [r0, #1556]
    str.w r6, [r0, #2420]
    str.w r7, [r0, #3284]
    str.w r8, [r1, #692]
    str.w r9, [r1, #1556]
    str.w r10, [r1, #2420]
    str.w r11, [r1, #3284]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #390]
    ldrsb.w r7, [r14, #606]
    ldrsb.w r9, [r14, #174]
    ldrsb.w r10, [r14, #822]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #696]
    str.w r5, [r0, #1560]
    str.w r6, [r0, #2424]
    str.w r7, [r0, #3288]
    str.w r8, [r1, #696]
    str.w r9, [r1, #1560]
    str.w r10, [r1, #2424]
    str.w r11, [r1, #3288]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #526]
    ldrsb.w r7, [r14, #94]
    ldrsb.w r8, [r14, #742]
    ldrsb.w r10, [r14, #310]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #700]
    str.w r5, [r0, #1564]
    str.w r6, [r0, #2428]
    str.w r7, [r0, #3292]
    str.w r8, [r1, #700]
    str.w r9, [r1, #1564]
    str.w r10, [r1, #2428]
    str.w r11, [r1, #3292]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #14]
    ldrsb.w r6, [r14, #662]
    ldrsb.w r8, [r14, #230]
    ldrsb.w r11, [r14, #446]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #704]
    str.w r5, [r0, #1568]
    str.w r6, [r0, #2432]
    str.w r7, [r0, #3296]
    str.w r8, [r1, #704]
    str.w r9, [r1, #1568]
    str.w r10, [r1, #2432]
    str.w r11, [r1, #3296]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #582]
    ldrsb.w r6, [r14, #150]
    ldrsb.w r7, [r14, #798]
    ldrsb.w r9, [r14, #366]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #708]
    str.w r5, [r0, #1572]
    str.w r6, [r0, #2436]
    str.w r7, [r0, #3300]
    str.w r8, [r1, #708]
    str.w r9, [r1, #1572]
    str.w r10, [r1, #2436]
    str.w r11, [r1, #3300]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #70]
    ldrsb.w r5, [r14, #718]
    ldrsb.w r7, [r14, #286]
    ldrsb.w r10, [r14, #502]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #712]
    str.w r5, [r0, #1576]
    str.w r6, [r0, #2440]
    str.w r7, [r0, #3304]
    str.w r8, [r1, #712]
    str.w r9, [r1, #1576]
    str.w r10, [r1, #2440]
    str.w r11, [r1, #3304]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #206]
    ldrsb.w r6, [r14, #854]
    ldrsb.w r8, [r14, #422]
    ldrsb.w r11, [r14, #638]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #716]
    str.w r5, [r0, #1580]
    str.w r6, [r0, #2444]
    str.w r7, [r0, #3308]
    str.w r8, [r1, #716]
    str.w r9, [r1, #1580]
    str.w r10, [r1, #2444]
    str.w r11, [r1, #3308]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #774]
    ldrsb.w r6, [r14, #342]
    ldrsb.w r9, [r14, #558]
    ldrsb.w r11, [r14, #126]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #720]
    str.w r5, [r0, #1584]
    str.w r6, [r0, #2448]
    str.w r7, [r0, #3312]
    str.w r8, [r1, #720]
    str.w r9, [r1, #1584]
    str.w r10, [r1, #2448]
    str.w r11, [r1, #3312]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #262]
    ldrsb.w r7, [r14, #478]
    ldrsb.w r9, [r14, #46]
    ldrsb.w r10, [r14, #694]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #724]
    str.w r5, [r0, #1588]
    str.w r6, [r0, #2452]
    str.w r7, [r0, #3316]
    str.w r8, [r1, #724]
    str.w r9, [r1, #1588]
    str.w r10, [r1, #2452]
    str.w r11, [r1, #3316]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #398]
    ldrsb.w r8, [r14, #614]
    ldrsb.w r10, [r14, #182]
    ldrsb.w r11, [r14, #830]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #728]
    str.w r5, [r0, #1592]
    str.w r6, [r0, #2456]
    str.w r7, [r0, #3320]
    str.w r8, [r1, #728]
    str.w r9, [r1, #1592]
    str.w r10, [r1, #2456]
    str.w r11, [r1, #3320]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #534]
    ldrsb.w r8, [r14, #102]
    ldrsb.w r9, [r14, #750]
    ldrsb.w r11, [r14, #318]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #732]
    str.w r5, [r0, #1596]
    str.w r6, [r0, #2460]
    str.w r7, [r0, #3324]
    str.w r8, [r1, #732]
    str.w r9, [r1, #1596]
    str.w r10, [r1, #2460]
    str.w r11, [r1, #3324]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #454]
    ldrsb.w r6, [r14, #22]
    ldrsb.w r7, [r14, #670]
    ldrsb.w r9, [r14, #238]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #736]
    str.w r5, [r0, #1600]
    str.w r6, [r0, #2464]
    str.w r7, [r0, #3328]
    str.w r8, [r1, #736]
    str.w r9, [r1, #1600]
    str.w r10, [r1, #2464]
    str.w r11, [r1, #3328]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #590]
    ldrsb.w r7, [r14, #158]
    ldrsb.w r8, [r14, #806]
    ldrsb.w r10, [r14, #374]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #740]
    str.w r5, [r0, #1604]
    str.w r6, [r0, #2468]
    str.w r7, [r0, #3332]
    str.w r8, [r1, #740]
    str.w r9, [r1, #1604]
    str.w r10, [r1, #2468]
    str.w r11, [r1, #3332]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #78]
    ldrsb.w r6, [r14, #726]
    ldrsb.w r8, [r14, #294]
    ldrsb.w r11, [r14, #510]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #744]
    str.w r5, [r0, #1608]
    str.w r6, [r0, #2472]
    str.w r7, [r0, #3336]
    str.w r8, [r1, #744]
    str.w r9, [r1, #1608]
    str.w r10, [r1, #2472]
    str.w r11, [r1, #3336]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #646]
    ldrsb.w r6, [r14, #214]
    ldrsb.w r9, [r14, #430]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #748]
    str.w r5, [r0, #1612]
    str.w r6, [r0, #2476]
    str.w r7, [r0, #3340]
    str.w r8, [r1, #748]
    str.w r9, [r1, #1612]
    str.w r10, [r1, #2476]
    str.w r11, [r1, #3340]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #134]
    ldrsb.w r5, [r14, #782]
    ldrsb.w r7, [r14, #350]
    ldrsb.w r10, [r14, #566]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #752]
    str.w r5, [r0, #1616]
    str.w r6, [r0, #2480]
    str.w r7, [r0, #3344]
    str.w r8, [r1, #752]
    str.w r9, [r1, #1616]
    str.w r10, [r1, #2480]
    str.w r11, [r1, #3344]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #135]
    ldrsb.w r5, [r14, #783]
    ldrsb.w r7, [r14, #351]
    ldrsb.w r10, [r14, #567]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #756]
    str.w r5, [r0, #1620]
    str.w r6, [r0, #2484]
    str.w r7, [r0, #3348]
    str.w r8, [r1, #756]
    str.w r9, [r1, #1620]
    str.w r10, [r1, #2484]
    str.w r11, [r1, #3348]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #271]
    ldrsb.w r8, [r14, #487]
    ldrsb.w r10, [r14, #55]
    ldrsb.w r11, [r14, #703]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #760]
    str.w r5, [r0, #1624]
    str.w r6, [r0, #2488]
    str.w r7, [r0, #3352]
    str.w r8, [r1, #760]
    str.w r9, [r1, #1624]
    str.w r10, [r1, #2488]
    str.w r11, [r1, #3352]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #839]
    ldrsb.w r6, [r14, #407]
    ldrsb.w r9, [r14, #623]
    ldrsb.w r11, [r14, #191]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #764]
    str.w r5, [r0, #1628]
    str.w r6, [r0, #2492]
    str.w r7, [r0, #3356]
    str.w r8, [r1, #764]
    str.w r9, [r1, #1628]
    str.w r10, [r1, #2492]
    str.w r11, [r1, #3356]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #327]
    ldrsb.w r7, [r14, #543]
    ldrsb.w r9, [r14, #111]
    ldrsb.w r10, [r14, #759]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #768]
    str.w r5, [r0, #1632]
    str.w r6, [r0, #2496]
    str.w r7, [r0, #3360]
    str.w r8, [r1, #768]
    str.w r9, [r1, #1632]
    str.w r10, [r1, #2496]
    str.w r11, [r1, #3360]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #463]
    ldrsb.w r7, [r14, #31]
    ldrsb.w r8, [r14, #679]
    ldrsb.w r10, [r14, #247]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #772]
    str.w r5, [r0, #1636]
    str.w r6, [r0, #2500]
    str.w r7, [r0, #3364]
    str.w r8, [r1, #772]
    str.w r9, [r1, #1636]
    str.w r10, [r1, #2500]
    str.w r11, [r1, #3364]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #599]
    ldrsb.w r8, [r14, #167]
    ldrsb.w r9, [r14, #815]
    ldrsb.w r11, [r14, #383]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #776]
    str.w r5, [r0, #1640]
    str.w r6, [r0, #2504]
    str.w r7, [r0, #3368]
    str.w r8, [r1, #776]
    str.w r9, [r1, #1640]
    str.w r10, [r1, #2504]
    str.w r11, [r1, #3368]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #519]
    ldrsb.w r6, [r14, #87]
    ldrsb.w r7, [r14, #735]
    ldrsb.w r9, [r14, #303]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #780]
    str.w r5, [r0, #1644]
    str.w r6, [r0, #2508]
    str.w r7, [r0, #3372]
    str.w r8, [r1, #780]
    str.w r9, [r1, #1644]
    str.w r10, [r1, #2508]
    str.w r11, [r1, #3372]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #7]
    ldrsb.w r5, [r14, #655]
    ldrsb.w r7, [r14, #223]
    ldrsb.w r10, [r14, #439]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #784]
    str.w r5, [r0, #1648]
    str.w r6, [r0, #2512]
    str.w r7, [r0, #3376]
    str.w r8, [r1, #784]
    str.w r9, [r1, #1648]
    str.w r10, [r1, #2512]
    str.w r11, [r1, #3376]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #143]
    ldrsb.w r6, [r14, #791]
    ldrsb.w r8, [r14, #359]
    ldrsb.w r11, [r14, #575]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #788]
    str.w r5, [r0, #1652]
    str.w r6, [r0, #2516]
    str.w r7, [r0, #3380]
    str.w r8, [r1, #788]
    str.w r9, [r1, #1652]
    str.w r10, [r1, #2516]
    str.w r11, [r1, #3380]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #711]
    ldrsb.w r6, [r14, #279]
    ldrsb.w r9, [r14, #495]
    ldrsb.w r11, [r14, #63]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #792]
    str.w r5, [r0, #1656]
    str.w r6, [r0, #2520]
    str.w r7, [r0, #3384]
    str.w r8, [r1, #792]
    str.w r9, [r1, #1656]
    str.w r10, [r1, #2520]
    str.w r11, [r1, #3384]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #199]
    ldrsb.w r5, [r14, #847]
    ldrsb.w r7, [r14, #415]
    ldrsb.w r10, [r14, #631]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #796]
    str.w r5, [r0, #1660]
    str.w r6, [r0, #2524]
    str.w r7, [r0, #3388]
    str.w r8, [r1, #796]
    str.w r9, [r1, #1660]
    str.w r10, [r1, #2524]
    str.w r11, [r1, #3388]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #335]
    ldrsb.w r8, [r14, #551]
    ldrsb.w r10, [r14, #119]
    ldrsb.w r11, [r14, #767]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #800]
    str.w r5, [r0, #1664]
    str.w r6, [r0, #2528]
    str.w r7, [r0, #3392]
    str.w r8, [r1, #800]
    str.w r9, [r1, #1664]
    str.w r10, [r1, #2528]
    str.w r11, [r1, #3392]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #471]
    ldrsb.w r8, [r14, #39]
    ldrsb.w r9, [r14, #687]
    ldrsb.w r11, [r14, #255]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #804]
    str.w r5, [r0, #1668]
    str.w r6, [r0, #2532]
    str.w r7, [r0, #3396]
    str.w r8, [r1, #804]
    str.w r9, [r1, #1668]
    str.w r10, [r1, #2532]
    str.w r11, [r1, #3396]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #391]
    ldrsb.w r7, [r14, #607]
    ldrsb.w r9, [r14, #175]
    ldrsb.w r10, [r14, #823]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #808]
    str.w r5, [r0, #1672]
    str.w r6, [r0, #2536]
    str.w r7, [r0, #3400]
    str.w r8, [r1, #808]
    str.w r9, [r1, #1672]
    str.w r10, [r1, #2536]
    str.w r11, [r1, #3400]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #527]
    ldrsb.w r7, [r14, #95]
    ldrsb.w r8, [r14, #743]
    ldrsb.w r10, [r14, #311]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #812]
    str.w r5, [r0, #1676]
    str.w r6, [r0, #2540]
    str.w r7, [r0, #3404]
    str.w r8, [r1, #812]
    str.w r9, [r1, #1676]
    str.w r10, [r1, #2540]
    str.w r11, [r1, #3404]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #15]
    ldrsb.w r6, [r14, #663]
    ldrsb.w r8, [r14, #231]
    ldrsb.w r11, [r14, #447]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #816]
    str.w r5, [r0, #1680]
    str.w r6, [r0, #2544]
    str.w r7, [r0, #3408]
    str.w r8, [r1, #816]
    str.w r9, [r1, #1680]
    str.w r10, [r1, #2544]
    str.w r11, [r1, #3408]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #583]
    ldrsb.w r6, [r14, #151]
    ldrsb.w r7, [r14, #799]
    ldrsb.w r9, [r14, #367]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #820]
    str.w r5, [r0, #1684]
    str.w r6, [r0, #2548]
    str.w r7, [r0, #3412]
    str.w r8, [r1, #820]
    str.w r9, [r1, #1684]
    str.w r10, [r1, #2548]
    str.w r11, [r1, #3412]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #71]
    ldrsb.w r5, [r14, #719]
    ldrsb.w r7, [r14, #287]
    ldrsb.w r10, [r14, #503]
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #824]
    str.w r5, [r0, #1688]
    str.w r6, [r0, #2552]
    str.w r7, [r0, #3416]
    str.w r8, [r1, #824]
    str.w r9, [r1, #1688]
    str.w r10, [r1, #2552]
    str.w r11, [r1, #3416]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #207]
    ldrsb.w r6, [r14, #855]
    ldrsb.w r8, [r14, #423]
    ldrsb.w r11, [r14, #639]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #828]
    str.w r5, [r0, #1692]
    str.w r6, [r0, #2556]
    str.w r7, [r0, #3420]
    str.w r8, [r1, #828]
    str.w r9, [r1, #1692]
    str.w r10, [r1, #2556]
    str.w r11, [r1, #3420]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #775]
    ldrsb.w r6, [r14, #343]
    ldrsb.w r9, [r14, #559]
    ldrsb.w r11, [r14, #127]
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #832]
    str.w r5, [r0, #1696]
    str.w r6, [r0, #2560]
    str.w r7, [r0, #3424]
    str.w r8, [r1, #832]
    str.w r9, [r1, #1696]
    str.w r10, [r1, #2560]
    str.w r11, [r1, #3424]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #263]
    ldrsb.w r7, [r14, #479]
    ldrsb.w r9, [r14, #47]
    ldrsb.w r10, [r14, #695]
    _3_layer_CT_butterfly_type_1001_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #836]
    str.w r5, [r0, #1700]
    str.w r6, [r0, #2564]
    str.w r7, [r0, #3428]
    str.w r8, [r1, #836]
    str.w r9, [r1, #1700]
    str.w r10, [r1, #2564]
    str.w r11, [r1, #3428]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #399]
    ldrsb.w r8, [r14, #615]
    ldrsb.w r10, [r14, #183]
    ldrsb.w r11, [r14, #831]
    _3_layer_CT_butterfly_type_0100_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #840]
    str.w r5, [r0, #1704]
    str.w r6, [r0, #2568]
    str.w r7, [r0, #3432]
    str.w r8, [r1, #840]
    str.w r9, [r1, #1704]
    str.w r10, [r1, #2568]
    str.w r11, [r1, #3432]
    vmov.w r14, s0
    ldrsb.w r6, [r14, #535]
    ldrsb.w r8, [r14, #103]
    ldrsb.w r9, [r14, #751]
    ldrsb.w r11, [r14, #319]
    _3_layer_CT_butterfly_type_0010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #844]
    str.w r5, [r0, #1708]
    str.w r6, [r0, #2572]
    str.w r7, [r0, #3436]
    str.w r8, [r1, #844]
    str.w r9, [r1, #1708]
    str.w r10, [r1, #2572]
    str.w r11, [r1, #3436]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #455]
    ldrsb.w r6, [r14, #23]
    ldrsb.w r7, [r14, #671]
    ldrsb.w r9, [r14, #239]
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #848]
    str.w r5, [r0, #1712]
    str.w r6, [r0, #2576]
    str.w r7, [r0, #3440]
    str.w r8, [r1, #848]
    str.w r9, [r1, #1712]
    str.w r10, [r1, #2576]
    str.w r11, [r1, #3440]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #591]
    ldrsb.w r7, [r14, #159]
    ldrsb.w r8, [r14, #807]
    ldrsb.w r10, [r14, #375]
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #852]
    str.w r5, [r0, #1716]
    str.w r6, [r0, #2580]
    str.w r7, [r0, #3444]
    str.w r8, [r1, #852]
    str.w r9, [r1, #1716]
    str.w r10, [r1, #2580]
    str.w r11, [r1, #3444]
    vmov.w r14, s0
    ldrsb.w r5, [r14, #79]
    ldrsb.w r6, [r14, #727]
    ldrsb.w r8, [r14, #295]
    ldrsb.w r11, [r14, #511]
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #856]
    str.w r5, [r0, #1720]
    str.w r6, [r0, #2584]
    str.w r7, [r0, #3448]
    str.w r8, [r1, #856]
    str.w r9, [r1, #1720]
    str.w r10, [r1, #2584]
    str.w r11, [r1, #3448]
    vmov.w r14, s0
    ldrsb.w r4, [r14, #647]
    ldrsb.w r6, [r14, #215]
    ldrsb.w r9, [r14, #431]
    movw r7, #0
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s1
    str.w r4, [r0, #860]
    str.w r5, [r0, #1724]
    str.w r6, [r0, #2588]
    str.w r7, [r0, #3452]
    str.w r8, [r1, #860]
    str.w r9, [r1, #1724]
    str.w r10, [r1, #2588]
    str.w r11, [r1, #3452]

    pop {r4-r12, pc}




