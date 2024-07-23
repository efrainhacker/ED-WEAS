text = "Kshai";
size = 20;

namefont = "Noto Sans Balinese:style=Bold";
sign_letter_height = 6; // Altura del letrero
hollow_letter_height = 6; // Altura de las letras huecas
background_thickness = -1; // Grosor del fondo del letrero
hollow_thickness = 0.3; // Grosor de la pared de las letras huecas
hollow_offset = 1; // Offset para el hueco de las letras
hollow_tolerance = 0.2; // Tolerancia para las letras huecas
sign_tolerance = 0.1; // Tolerancia para el letrero
internal_sign_tolerance = 0.1; // Tolerancia interna de las letras del letrero

module sign_with_cutout(t = text, height = sign_letter_height, tol = sign_tolerance, int_tol = internal_sign_tolerance) {
    difference() {
        // Fondo del letrero con recorte
        linear_extrude(height + background_thickness)
            offset(size / 6 + tol)
                text(t, size, font = namefont);
        
        // Letras recortadas con tolerancia interna
        translate([0, 0, -background_thickness]) {
            linear_extrude(height + background_thickness) {
                offset(-int_tol)
                    text(t, size, font = namefont);
            }
        }
    }
}

module hollow_letters(t = text, height = hollow_letter_height, tol = hollow_tolerance) {
    difference() {
        // Letras principales
        linear_extrude(height)
            text(t, size, font = namefont);
        
        // Crear hueco en las letras desde la parte inferior con tolerancia
        translate([0, 0, hollow_offset]) {
            linear_extrude(height - hollow_offset) {
                offset(-hollow_thickness - tol)
                    text(t, size, font = namefont);
            }
        }
    }
}

// Generar el letrero con letras recortadas
translate([0, 0, 0])
    sign_with_cutout(text, sign_letter_height, sign_tolerance, internal_sign_tolerance);

// Generar las letras huecas separadas con tolerancia
translate([0, -50, 0]) // Ajusta la posición para que no se solapen
    hollow_letters(text, hollow_letter_height, hollow_tolerance);

/*
// Custom kerned multi-line sign example
size = 9;
sign_letter_height = 2;

union() {
    translate([0, 0, 0]) sign("Problem");
    translate([63, 0, 0]) sign("Sol");
    translate([84, 0, 0]) sign("ving");
    translate([23, -22, 0]) sign("isMyDrug");
    translate([23, -44, 0]) sign("ofChoice");
    color("darkslategray") translate([58, -15, 0]) cylinder(h = 1, d = 50);
}
*/
