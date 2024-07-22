/*
Phantom Fingers font found at:
https://www.1001fonts.com/phantom-fingers-font.html

Note that the Fill function requires the development release of OpenSCAD
https://openscad.org/downloads.html#snapshots
*/

text = "Danger!";
size = 20;

namefont = "Phantom Fingers:style=Regular";
main_letter_height = 6;
background_thickness = 2; // Grosor del fondo del letrero
hollow_thickness = 1.5; // Grosor de la pared de las letras huecas
hollow_direction = "top"; // Dirección de la parte hueca ("top" o "bottom")
tolerance = 0.2; // Tolerancia para que las letras encajen
hollow_letter_height = 4; // Altura de las letras huecas

module sign_with_cutout(t = text) {
    difference() {
        // Fondo del letrero con recorte
        linear_extrude(main_letter_height + background_thickness + tolerance)
            offset(size / 6 + tolerance)
                text(t, size, font = namefont);
        
        // Letras recortadas
        translate([0, 0, -background_thickness]) {
            linear_extrude(main_letter_height + background_thickness) {
                text(t, size, font = namefont);
            }
        }
    }
}

module hollow_letters(t = text, direction = "top", height = hollow_letter_height) {
    difference() {
        // Letras principales
        linear_extrude(height)
            text(t, size, font = namefont);
        
        if (direction == "top") {
            // Crear hueco en las letras desde la parte superior
            linear_extrude(height - hollow_thickness) {
                offset(-hollow_thickness)
                    translate([0, 0, hollow_thickness])
                        text(t, size, font = namefont);
            }
        } else {
            // Crear hueco en las letras desde la parte inferior
            linear_extrude(height - hollow_thickness) {
                offset(-hollow_thickness)
                    text(t, size, font = namefont);
            }
        }
    }
}

// Generar el letrero con letras recortadas
translate([0, 0, 0])
    sign_with_cutout(text);

// Generar las letras huecas separadas (ajustando la posición para que no se solapen)
translate([0, -50, 0])
    hollow_letters(text, hollow_direction, hollow_letter_height);

/*
// Custom kerned multi-line sign example
size = 9;
main_letter_height = 2;
union() {
    translate([0, 0, 0]) sign("Problem");
    translate([63, 0, 0]) sign("Sol");
    translate([84, 0, 0]) sign("ving");
    translate([23, -22, 0]) sign("isMyDrug");
    translate([23, -44, 0]) sign("ofChoice");
    color("darkslategray") translate([58, -15, 0]) cylinder(h = 1, d = 50);
}
*/

