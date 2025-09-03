import tkinter as tk
from PIL import Image, ImageTk

fotolar = ["1.png", "2.png", "3.png", "4.png", "5.png"]

pencere = tk.Tk()
pencere.title("Hikaye")
pencere.attributes('-fullscreen', True)

screen_width = pencere.winfo_screenwidth()
screen_height = pencere.winfo_screenheight()

etiket = tk.Label(pencere)
etiket.pack()

index = 0
def goster():
    global index, photo
    img = Image.open(fotolar[index])
    img = img.resize((screen_width, screen_height))
    photo = ImageTk.PhotoImage(img)
    etiket.config(image=photo)
    index += 1
    if index < len(fotolar):
        pencere.after(5000, goster)  # 5000ms = 5 saniye

# Başlat
goster()

# Çıkmak için ESC tuşu
def cikis(event):
    pencere.destroy()

pencere.bind("<Escape>", cikis)
pencere.mainloop()
