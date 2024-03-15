Config = {}
Config.debug = false   -- leave false on live servers 

Config.Location = {
    Blackwater = { --location name 
        Pedstoremove = --list of peds to remove from the efected area 
        {"mp_a_c_deer_01","a_c_deer_01","a_c_buck_01","mp_a_c_buck_01","mp_a_c_pronghorn_01","a_c_pronghorn_01","a_c_coyote_01","mp_a_c_coyote_01"},
        coords = vector3(-825.2, -1306.18, 43.6), 
        radius = 120.0   -- radius around the cords to effect 
    },
    valentine = {
        Pedstoremove = {"mp_a_c_deer_01","a_c_deer_01","a_c_buck_01","mp_a_c_buck_01","mp_a_c_pronghorn_01","a_c_pronghorn_01","a_c_coyote_01","mp_a_c_coyote_01"},
        coords = vector3(-295.86, 790.62, 118.46),
        radius = 90.0
    }, 
    StDnise = {
        Pedstoremove = {"mp_a_c_deer_01","a_c_deer_01","a_c_buck_01","mp_a_c_buck_01","mp_a_c_pronghorn_01","a_c_pronghorn_01","a_c_coyote_01","mp_a_c_coyote_01"},
        coords = vector3(2654.09, -1240.02, 53.23),
        radius = 250.0
        
    },
    Annesburg = {
        Pedstoremove = {"mp_a_c_deer_01","a_c_deer_01","a_c_buck_01","mp_a_c_buck_01","mp_a_c_pronghorn_01","a_c_pronghorn_01","a_c_coyote_01","mp_a_c_coyote_01"},
        coords =vector3(2932.87, 1339.62, 44.05),
        radius = 90.0
    },
    armmadillo= {
        Pedstoremove = {"mp_a_c_deer_01","a_c_deer_01","a_c_buck_01","mp_a_c_buck_01","mp_a_c_pronghorn_01","a_c_pronghorn_01","a_c_coyote_01","mp_a_c_coyote_01"},
        coords =vector3(-3677.07, -2611.77, -14.08),
        radius = 90.0
    },
    
}




