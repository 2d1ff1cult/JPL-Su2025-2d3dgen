# file: chat_cadrille.py
import torch
from transformers import AutoProcessor
from cadrille import Cadrille
import sys

sys.path.append(".")

# load the model & processor
print("Loading model")
model = Cadrille.from_pretrained(
    "maksimko123/cadrille",
    torch_dtype=torch.bfloat16,
    # set to eager or torch if running into issues with flashattn
    # options are: "eager", "torch", "flash_attention_2"
    attn_implementation="eager",
    device_map="auto"
)
print("Loading processor...")
processor = AutoProcessor.from_pretrained(
    "Qwen/Qwen2-VL-2B-Instruct",
    min_pixels=256*28*28, max_pixels=1280*28*28, padding_side="left", use_fast=True
)
print(f"Processor: {processor}")
print("Model loaded")

model.eval()
print("Enter a text prompt (or ‘quit’ to exit).")
while True:
    prompt = input(">>> ")
    if prompt.lower() in ("quit", "exit"):
        break

    # prepare inputs
    inputs = processor(
        text=prompt,
        return_tensors="pt",
        padding=True
    ).to(model.device)
    input_ids = inputs.input_ids

    # generate up to 768 new tokens
    out_ids = model.generate(
        input_ids=inputs.input_ids,
        attention_mask=inputs.attention_mask,
        max_new_tokens=768,
        point_clouds=None,
        is_pc=torch.tensor([False], device=model.device),
        is_img=torch.tensor([False], device=model.device)
    )[0]

    # strip off the prompt tokens
    new_tokens = out_ids[input_ids.shape[-1]:]
    code = processor.decode(new_tokens, skip_special_tokens=True)
    print("\n=== Generated CadQuery script ===\n")
    print(code)
    print("\n=================================\n") 