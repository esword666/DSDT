DefinitionBlock ("GA-B74M-D3V-F13.aml", "SSDT", 1, "APPLE", "TinySSDT", 0x00001000)
{
    //External (\IOST, IntObj)

    External (\_SB_.PCI0, DeviceObj)
    //External (\_SB_.WCAM, DeviceObj)

    External (\_SB_.LNKA._STA, IntObj)
    External (\_SB_.LNKB._STA, IntObj)
    External (\_SB_.LNKC._STA, IntObj)
    External (\_SB_.LNKD._STA, IntObj)
    External (\_SB_.LNKE._STA, IntObj)
    External (\_SB_.LNKF._STA, IntObj)
    External (\_SB_.LNKG._STA, IntObj)
    External (\_SB_.LNKH._STA, IntObj)

    //External (\_SB_.PCI0.B0D3._STA, IntObj)
    External (\_SB_.PCI0.B0D4, DeviceObj)
    External (\_SB_.PCI0.GFX0, DeviceObj)
    External (\_SB_.PCI0.HDEF, DeviceObj)
    External (\_SB_.PCI0.LPCB, DeviceObj)
    External (\_SB_.PCI0.LPCB.SIO1, DeviceObj)
    External (\_SB_.PCI0.RP05, DeviceObj)
    External (\_SB_.PCI0.RP05.PXSX, DeviceObj)
    External (\_SB_.PCI0.PEG0, DeviceObj)
    External (\_SB_.PCI0.SAT0, DeviceObj)
    External (\_SB_.PCI0.SAT1, DeviceObj)
    External (\_SB_.PCI0.TPMX._STA, DeviceObj)
    //External (\_SB_.PCI0.WMI1, DeviceObj)

    External (\_TZ_.FAN0, DeviceObj)
    External (\_TZ_.FAN1, DeviceObj)
    External (\_TZ_.FAN2, DeviceObj)
    External (\_TZ_.FAN3, DeviceObj)
    External (\_TZ_.FAN4, DeviceObj)

    External (\_TZ_.TZ00, PkgObj)
    External (\_TZ_.TZ01, PkgObj)
    
    Name (TMAC, "GA-B74M-D3V-F13 edits by Kwanlam")

    Scope (\)
    {
        Scope (\_SB_)
        {
            Method (_INI, 0, NotSerialized)
            {
                /* Here we disable/hide Devices (LNKx) */
                Store (Zero, \_SB_.LNKA._STA)
                Store (Zero, \_SB_.LNKB._STA)
                Store (Zero, \_SB_.LNKC._STA)
                Store (Zero, \_SB_.LNKD._STA)
                Store (Zero, \_SB_.LNKE._STA)
                Store (Zero, \_SB_.LNKF._STA)
                Store (Zero, \_SB_.LNKG._STA)
                Store (Zero, \_SB_.LNKH._STA)
                
                /* Here we disable/hide Devices (B0D3) */
                //Store (Zero, \_SB_.PCI0.B0D3._STA)
                
                /* Here we disable/hide Devices (TMPX) */
                Store (Zero, \_SB_.PCI0.TPMX._STA)
                
                /* Here we disable/hide Devices (PS2x) */
                //Store (Zero, \IOST)
                
                /* Here we disable/hide ThermalZone (TZ0n) */
                Store (Zero, \_TZ_.TZ00)
                Store (Zero, \_TZ_.TZ01)
            }
            
            /* Here we disable/hide Device (WCAM) */
            /*
            Scope (WCAM)
            {
                Name (_STA, Zero)
            }*/
            
            Scope (PCI0)
            {
                /* Here we inject a new Device (MCHC) */
                Device (MCHC)
                {
                    Name (_ADR, Zero)
                }
                
                /* Here we inject a new Device (HECI) */
                Device (HECI)
                {
                    Name (_ADR, 0x00160000)
                }
                
                /* Here we disable/hide Device (GFX0) */
                Scope (GFX0)
                {
                    Name (_STA, Zero)
                }
                
                /* Here we inject a new Device (IGPU) */
                Device (IGPU)
                {
                    Name (_ADR, 0x00020000) // _ADR: Address
                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (Arg2, Zero))
                        {
                            Return (Buffer (One)
                            {
                                0x03
                            })
                        }
                        
                        Return (Package (0x04)
                        {
                            "AAPL00,override-no-edid", Buffer (0x80)
                            {
                                /* 0000 */ 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
                                /* 0008 */ 0x30, 0xAE, 0x42, 0x10, 0xB5, 0xC3, 0x00, 0x00,
                                /* 0010 */ 0x1D, 0x15, 0x01, 0x03, 0x68, 0x1E, 0x17, 0x78,
                                /* 0018 */ 0x2A, 0xF7, 0xC5, 0xA3, 0x55, 0x4C, 0x9B, 0x25,
                                /* 0020 */ 0x12, 0x50, 0x54, 0xBD, 0xCE, 0x00, 0x61, 0x40,
                                /* 0028 */ 0x61, 0x4C, 0x61, 0x4F, 0x31, 0x0A, 0x01, 0x01,
                                /* 0030 */ 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x64, 0x19,
                                /* 0038 */ 0x00, 0x40, 0x41, 0x00, 0x26, 0x30, 0x18, 0x88,
                                /* 0040 */ 0x36, 0x00, 0x30, 0xE4, 0x10, 0x00, 0x00, 0x1E,
                                /* 0048 */ 0x00, 0x00, 0x00, 0xFF, 0x00, 0x38, 0x34, 0x33,
                                /* 0050 */ 0x33, 0x36, 0x42, 0x32, 0x39, 0x35, 0x30, 0x31,
                                /* 0058 */ 0x30, 0x31, 0x00, 0x00, 0x00, 0xFD, 0x00, 0x32,
                                /* 0060 */ 0x4C, 0x1E, 0x3D, 0x08, 0x00, 0x0A, 0x20, 0x20,
                                /* 0068 */ 0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xFC,
                                /* 0070 */ 0x00, 0x4C, 0x45, 0x4E, 0x20, 0x4C, 0x31, 0x35,
                                /* 0078 */ 0x31, 0x30, 0x0A, 0x20, 0x20, 0x20, 0x00, 0x70
                            },
                            "hda-gfx",
                            Buffer (0x0A)
                            {
                                "onboard-1"
                            }
                        })
                    }
                }
                
                /* Here we inject a new Device (HDAU) */
                /*
                Device (HDAU)
                {
                    Name (_ADR, 0x00030000)
                    Name (_STA, 0x0F) // _STA: Status                    
                    OperationRegion (HDAH, PCI_Config, 0x54, One)
                    Field (HDAH, ByteAcc, NoLock, Preserve)
                    {
                            ,   5,
                        AUDE,   1
                    }
                    
                    Method (_INI, 0, NotSerialized)
                    {
                        Store (One, AUDE)
                        Notify (PCI0, Zero)
                    }
                    
                    //Here we inject a new Method (_DSM)
                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (Arg2, Zero))
                        {
                            Return (Buffer (One)
                            {
                                0x03
                            })
                        }
                        Return (Package (0x02)
                        {
                            "hda-gfx",
                            Buffer (0x0A)
                            {
                                "onboard-1"
                            }
                        })
                    }
                }*/
                
                /* Here we disable/hide Device (B0D4) */
                Scope (B0D4)
                {
                    Name (_STA, Zero)
                }
                
                /* Here we add (audio related) properties to Device (HDEF) */
                Scope (HDEF)
                {
                    /* Here we inject a new Method (_DSM) */
                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (Arg2, Zero))
                        {
                            Return (Buffer (One)
                            {
                                0x03
                            })
                        }
                        Return (Package (0x02)
                        {
                            "layout-id",
                            Buffer (0x04)
                            {
                                0x05, 0x00, 0x00, 0x00
                            }//,
                            //"PinConfigurations",
                            //Buffer (Zero) {}
                        })
                    }
                }
                
                Scope (LPCB)
                {
                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (Arg2, Zero))
                        {
                            Return (Buffer (One)
                            {
                                0x03
                            })
                        }
                        Return (Package (0x02)
                        {
                            "compatible", "pci8086,1e44"
                        })
                    }
                    
                    /* Here we disable/hide Device (SIO1) */
                    Scope (SIO1)
                    {
                        Name (_STA, Zero)
                    }
                }
                
                /* RP05 is used for my Wifi/Bluetooth 4.0 card, installed in slot 'PCIEX4' */
                Scope (RP05)
                {
                    /* Here we disable/hide Device (PXSX) */
                    Scope (PXSX)
                    {
                        Name (_STA, Zero)
                    }
                    
                    /* Here we inject a new device (ARPT) */
                    Device (GIGE)
                    {
                        Name (_ADR, Zero)
                        Name (_PRW, Package (0x02)
                        {
                            0x09,
                            0x04
                        })
                    }
                }
                
                /* PEG0 is used for my GTX1060, installed in slot 'PCIEX16' */
                Scope (PEG0)
                {
                    /* Here we inject a new device (PEGP) for the GTX1060 */
                    Device (PEGP)
                    {
                        Name (_ADR, 0xFFFF)  // _ADR: Address
                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            If (LEqual (Arg2, Zero))
                            {
                                Return (Buffer (One)
                                {
                                    0x03
                                })
                            }
                            Return (Package(One)
                            {
                                "AAPL00,override-no-edid", Buffer (One)
                                {
                                    /* 0000 */ 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
                                    /* 0008 */ 0x09, 0xD1, 0xA6, 0x76, 0x24, 0x39, 0x00, 0x00,
                                    /* 0010 */ 0x10, 0x11, 0x01, 0x03, 0x80, 0x26, 0x1E, 0x78,
                                    /* 0018 */ 0xEA, 0x6D, 0x66, 0xA2, 0x5A, 0x4C, 0x9D, 0x23,
                                    /* 0020 */ 0x13, 0x4F, 0x54, 0xBD, 0xEF, 0x80, 0x71, 0x4F,
                                    /* 0028 */ 0x81, 0x90, 0x81, 0x80, 0x81, 0x8C, 0x01, 0x01,
                                    /* 0030 */ 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x30, 0x2A,
                                    /* 0038 */ 0x00, 0x98, 0x51, 0x00, 0x2A, 0x40, 0x30, 0x70,
                                    /* 0040 */ 0x13, 0x00, 0x78, 0x2D, 0x11, 0x00, 0x00, 0x1E,
                                    /* 0048 */ 0xD5, 0x09, 0x80, 0xA0, 0x20, 0x5E, 0x63, 0x10,
                                    /* 0050 */ 0x10, 0x60, 0x52, 0x08, 0x78, 0x2D, 0x11, 0x00,
                                    /* 0058 */ 0x00, 0x1A, 0x00, 0x00, 0x00, 0xFD, 0x00, 0x38,
                                    /* 0060 */ 0x4C, 0x1F, 0x53, 0x0E, 0x00, 0x0A, 0x20, 0x20,
                                    /* 0068 */ 0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xFC,
                                    /* 0070 */ 0x00, 0x42, 0x65, 0x6E, 0x51, 0x20, 0x46, 0x50,
                                    /* 0078 */ 0x39, 0x31, 0x47, 0x2B, 0x0A, 0x20, 0x00, 0x1E
                                }
                            })
                        }
                    }
                }
                
                /* Here we disable/hide Device (SAT0) */
                Scope (SAT0)
                {
                    Name (_STA, Zero)
                }
                
                /* Here we disable/hide Device (SAT1) */
                Scope (SAT1)
                {
                    Name (_STA, Zero)
                }
                
                /* Here we inject a new Device (SATA) */
                Device (SATA)
                {
                    Name (_ADR, 0x001F0002)
                }
                
                /* Here we disable/hide Device (WMI1) */
                /*
                Scope (WMI1)
                {
                    Name (_STA, Zero)
                }*/
            }
        }
        
        Scope (\_TZ_)
        {
            /* Here we disable/hide Device (FAN0) */
            Scope (FAN0)
            {
                Name (_STA, Zero)
            }
            
            /* Here we disable/hide Device (FAN1) */
            Scope (FAN1)
            {
                Name (_STA, Zero)
            }
            
            /* Here we disable/hide Device (FAN2) */
            Scope (FAN2)
            {
                Name (_STA, Zero)
            }
            
            /* Here we disable/hide Device (FAN3) */
            Scope (FAN3)
            {
                Name (_STA, Zero)
            }
            
            /* Here we disable/hide Device (FAN4) */
            Scope (FAN4)
            {
                Name (_STA, Zero)
            }
        }
    }
}
