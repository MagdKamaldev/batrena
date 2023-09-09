
extern crate image;
use image::{GenericImageView, ImageBuffer, Rgba};

// use serde_json::Result;
// struct Tooth {
//     ToothID: usize,
//     ToothCode: String,
//     Condition: String,
// }

// impl Tooth {
//     pub fn new() -> Self {
//         Tooth { ToothID: 0, ToothCode: "".to_string(), Condition: "".to_string() }
//     }
// }

// struct TeethMap {
//     Teeth: Vec<Tooth>
// }

// impl TeethMap {
//     pub fn new() -> Self {
//         TeethMap { Teeth:  }
//     }
// }

// struct Patient {
//     Name: String,
//     Phone: String,
//     TeethMap: TeethMap
// }

    
pub fn replacePixels(image_bytes: Vec<u8>, hex_color: String) -> Vec<u8>  {
    let hex_color = hex_color.trim_start_matches('#');
    let (r, g, b, a) = match hex_color.len() {
        3 => (
            u8::from_str_radix(&hex_color[0..1].repeat(2), 16).unwrap(),
            u8::from_str_radix(&hex_color[1..2].repeat(2), 16).unwrap(),
            u8::from_str_radix(&hex_color[2..3].repeat(2), 16).unwrap(),
            255,
        ),
        6 => (
            u8::from_str_radix(&hex_color[0..2], 16).unwrap(),
            u8::from_str_radix(&hex_color[2..4], 16).unwrap(),
            u8::from_str_radix(&hex_color[4..6], 16).unwrap(),
            255,
        ),
        8 => (
            u8::from_str_radix(&hex_color[0..2], 16).unwrap(),
            u8::from_str_radix(&hex_color[2..4], 16).unwrap(),
            u8::from_str_radix(&hex_color[4..6], 16).unwrap(),
            u8::from_str_radix(&hex_color[6..8], 16).unwrap(),
        ),
        _ => panic!("Invalid hexadecimal color string: {}", hex_color),
    };
    let outColor = Rgba([r, g, b, a]);
    let img = image::load_from_memory_with_format(&image_bytes, image::ImageFormat::Png)
    .expect("Failed to load image");

// Create an empty buffer to hold the modified image
let (width, height) = img.dimensions();
let mut out_img = ImageBuffer::new(width, height);
let target_color: &Rgba<u8> = &Rgba([167, 24, 24, 255]);

// Loop over the image pixels and replace the target color with white
for (x, y, pixel) in img.to_rgba8().enumerate_pixels() {
    if pixel == target_color {
        out_img.put_pixel(x, y, outColor);
    } else {
        out_img.put_pixel(x, y, Rgba([pixel[0], pixel[1], pixel[2], pixel[3]]));
    }
}

// Encode the modified image to bytes
let mut output_buffer = Vec::new();
image::codecs::png::PNGEncoder::new(&mut output_buffer)
    .encode(
        out_img.as_raw(),
        out_img.width(),
        out_img.height(),
        image::ColorType::Rgba8,
    )
    .unwrap();
output_buffer
}



// impl Treatment {
//     pub fn new() -> Self {
//         Treatment { ID: 0, name: "".to_string(), price: 0.0, color: "".to_string() }
//     }
// }