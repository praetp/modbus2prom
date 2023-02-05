BEGIN {
    # now = systime() * 1000 #no milliseconds in awk :(

    divisors["PV1Volt"] = 10
    divisors["PV1Curr"] = 100
    divisors["PV1Power"] = 10 #different from the documentation ?
    divisors["PV2Volt"] = 10
    divisors["PV2Curr"] = 100
    divisors["PV2Power"] = 10 #different from the documentation ?
   
    divisors["InvTempC"] = 10
    divisors["Power"] = 1

    divisors["Today_Energy"] = 100
    divisors["Month_Energy"] = 100
    divisors["Year_Energy"] = 100
    divisors["Total_Energy"] = 100

    units["PV1Volt"] = "volt"
    units["PV1Curr"] = "ampere"
    units["PV1Power"] = "watt"
    units["PV2Volt"] = "volt"
    units["PV2Curr"] = "ampere"
    units["PV2Power"] = "watt"

    units["InvTempC"] = "celsius"
    units["Power"] = "watt"

    units["Today_Energy"] = "kWh"
    units["Month_Energy"] = "kWh"
    units["Year_Energy"] = "kWh"
    units["Total_Energy"] = "kWh"

}

{  
    
    key = substr($1, 0, length($1)-1)
    value = $2 / divisors[key]
    unit = units[key]
    # printf("%s %4.2lf%s\n", key, value, unit)
    if (match(key, "^PV(.)Volt$", a) != 0) {
        printf("pv_dc_voltage_%s{circuit=\"%d\"} %4.2lf\n", unit, a[1], value)
    } else if (match(key, "^PV(.)Curr$", a) != 0) {
        printf("pv_dc_current_%s{circuit=\"%d\"} %4.2lf\n", unit, a[1], value)
    } else if (match(key, "^PV(.)Power$", a) != 0) {
        printf("pv_dc_power_%s{circuit=\"%d\"} %4.2lf\n", unit, a[1], value)
    } else if (match(key, "^(.+)_Energy", a) != 0) {
        printf("pv_energy_%s{timerange=\"%s\"} %4.2lf\n", unit, tolower(a[1]), value)
    } else if (key == "Power") {
        printf("pv_ac_energy_%s  %4.2lf\n", unit, value)
    } else if (key == "InvTempC") {
        printf("pv_inv_temperature_%s %4.2lf\n", unit, value)
    }

}

