import gradio as gr
import cv2
import torch
from basicsr.archs.rrdbnet_arch import RRDBNet
from realesrgan import RealESRGANer

def upscale_image(input_image):
    # Initialize the model
    model = RRDBNet(num_in_ch=3, num_out_ch=3, num_feat=64, num_block=23, num_grow_ch=32, scale=4)
    upsampler = RealESRGANer(
        scale=4,
        model_path='weights/RealESRGAN_x4plus.pth',
        model=model,
        tile=0,
        tile_pad=10,
        pre_pad=0,
        half=True
    )
    
    # Convert the input image to a format compatible with Real-ESRGAN
    input_image = cv2.cvtColor(input_image, cv2.COLOR_BGR2RGB)
    
    # Perform the upscaling
    output_image, _ = upsampler.enhance(input_image, outscale=4)
    
    return cv2.cvtColor(output_image, cv2.COLOR_RGB2BGR)

# Define the Gradio interface
iface = gr.Interface(
    fn=upscale_image,
    inputs=gr.Image(type="numpy"),
    outputs=gr.Image(type="numpy"),
    title="Real-ESRGAN Image Upscaler",
    description="Upload an image to upscale using Real-ESRGAN."
)

if __name__ == "__main__":
    iface.launch(server_name="0.0.0.0", server_port=7860)

