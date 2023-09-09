mod apis;
use std::fs::File;
use std::io::prelude::*;

use crate::apis::replacePixels;

fn load_image(path: &str) -> Vec<u8> {
    // Open the image file
    let mut file = File::open(path).expect("Failed to open file");

    // Read the contents of the file into a vector
    let mut contents = Vec::new();
    file.read_to_end(&mut contents).expect("Failed to read file");

    contents
}

fn save_image(data: &Vec<u8>, path: &str) -> std::io::Result<()> {
    let mut file = File::create(path)?;
    file.write_all(&data)?;
    Ok(())
}

fn main () {
    let path = "branch_location.png";
    let mut image_data = load_image(path);
    image_data = replacePixels(image_data, "#a68109".to_string());
    save_image(&image_data, "output.png");
}
