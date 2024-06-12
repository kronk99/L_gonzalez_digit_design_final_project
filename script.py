def generate_ascii_mif(text):
    ascii_dict = {
        'A': 65,
        'B': 66,
        'C': 67,
        'D': 68,
        'E': 69,
        'F': 70,
        'G': 71,
        'H': 72,
        'I': 73,
        'J': 74,
        'K': 75,
        'L': 76,
        'M': 77,
        'N': 78,
        'O': 79,
        'P': 80,
        'Q': 81,
        'R': 82,
        'S': 83,
        'T': 84,
        'U': 85,
        'V': 86,
        'W': 87,
        'X': 88,
        'Y': 89,
        'Z': 90,
        '*': 91
    }

    mif_content = "-- Copyright (C) 2020  Intel Corporation. All rights reserved.\n"
    mif_content += "-- Your use of Intel Corporation's design tools, logic functions\n"
    mif_content += "-- and other software and tools, and any partner logic\n"
    mif_content += "-- functions, and any output files from any of the foregoing\n"
    mif_content += "-- (including device programming or simulation files), and any\n"
    mif_content += "-- associated documentation or information are expressly subject\n"
    mif_content += "-- to the terms and conditions of the Intel Program License\n"
    mif_content += "-- Subscription Agreement, the Intel Quartus Prime License Agreement,\n"
    mif_content += "-- the Intel FPGA IP License Agreement, or other applicable license\n"
    mif_content += "-- agreement, including, without limitation, that your use is for\n"
    mif_content += "-- the sole purpose of programming logic devices manufactured by\n"
    mif_content += "-- Intel and sold by Intel or its authorized distributors.  Please\n"
    mif_content += "-- refer to the applicable agreement for further details, at\n"
    mif_content += "-- https://fpgasoftware.intel.com/eula.\n\n"
    mif_content += "-- Quartus Prime generated Memory Initialization File (.mif)\n\n"
    mif_content += "WIDTH=8;\n"
    mif_content += "DEPTH=1024;\n\n"
    mif_content += "ADDRESS_RADIX=UNS;\n"
    mif_content += "DATA_RADIX=UNS;\n\n"
    mif_content += "CONTENT BEGIN\n"
    
    address = 0
    for char in text:
        char_ascii = ord(char.upper())
        if char_ascii in ascii_dict.values():
            mif_content += f"\t{address}: {char_ascii};\n"
            address += 1
        else:
            mif_content += f"\t{address}: 0;\n"
            address += 1

    mif_content += "\t[{}..1023]  :   0;\n".format(address)
    mif_content += "END;\n"

    with open("C:\\Users\\manue\\Escritorio\\dbrenes_digital_design_lab_2024\\proyecto_final\\Procesador\\datafile.mif", "w") as f:
        f.write(mif_content)

# Ejemplo de uso
texto = "IN THE DUSTY ATTIC OF THE OLD HOUSE, AN OLD GRANDFATHER CLOCK KEPT TIME WITH A STEADY TICKING. ITS CARVED WOOD AND TARNISHED FACE SPOKE OF A BYGONE ERA, OF FORGOTTEN STORIES AND SECRETS HELD WITHIN ITS GEARS. ONE DAY, A CURIOUS BOY NAMED THOMAS CLIMBED INTO THE ATTIC AND CAME ACROSS THE OLD CLOCK. FASCINATED BY ITS PRESENCE, HE TOUCHED IT GENTLY, FEELING THE ROUGHNESS OF THE WOOD BENEATH HIS FINGERS. SUDDENLY, THE CLOCK CAME TO LIFE, ITS HANDS SPINNING WILDLY AND EMITTING A METALLIC SOUND THAT ECHOED THROUGH THE HOUSE. THOMAS, UNAFRAID, APPROACHED THE CLOCK AND STARED INTO ITS EYES. IN THAT MOMENT, A WAVE OF MEMORIES WASHED OVER HIM, IMAGES OF PEOPLE AND PLACES HE HAD NEVER SEEN BEFORE. THE CLOCK WAS SHOWING HIM HIS PAST, THE STORIES IT HAD WITNESSED OVER THE YEARS. THOMAS SPENT HOURS LISTENING TO THE CLOCK'S STORIES, LEARNING ABOUT THE LIVES OF HIS ANCESTORS AND THE SECRETS THEY HAD KEPT. THE OLD CLOCK BECAME HIS FRIEND, A LINK TO HIS PAST AND A SOURCE OF ENDLESS WISDOM."
generate_ascii_mif(texto)
print("Archivo .mif generado exitosamente.")
