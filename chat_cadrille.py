# file: chat_cadrille.py
import torch
from transformers import AutoProcessor
from cadrille import Cadrille

# load the model & processor
model = Cadrille.from_pretrained(
    "maksimko123/cadrille",
    torch_dtype=torch.bfloat16,
    attn_implementation="flash_attention_2",
    device_map="auto"
)
processor = AutoProcessor.from_pretrained(
    "Qwen/Qwen2-VL-2B-Instruct",
    min_pixels=256*28*28, max_pixels=1280*28*28, padding_side="left"
)

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

    # generate up to 768 new tokens
    out_ids = model.generate(
        input_ids=inputs.input_ids,
        attention_mask=inputs.attention_mask,
        max_new_tokens=768
    )[0]

    # strip off the prompt tokens
    new_tokens = out_ids[input_ids.shape[-1]:]
    code = processor.decode(new_tokens, skip_special_tokens=True)
    print("\n=== Generated CadQuery script ===\n")
    print(code)
    print("\n=================================\n")
