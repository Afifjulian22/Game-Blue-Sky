SPRITE KARAKTER AFIF - HASIL PERATAAN (ALIGNED)
==============================================

Sumber (tidak diubah):
   afif-removebg-preview.png
   falling-removebg-preview.png
   hit-removebg-preview.png

Hasil ada di folder ini:
   afif-aligned.png       sprite sheet Afif (5 baris)
   falling-aligned.png    sprite sheet jatuh (3 baris)
   hit-aligned.png        sprite sheet kena pukul (5 baris)
   rows\*.png             potongan per baris, siap dimasukkan ke Godot
   gif\*.gif              pratinjau animasi tiap baris
   preview_grid.png       pratinjau + garis grid + nomor frame
   pivot_guide.png        contoh titik pivot (kaki) di dalam sel

UKURAN SEL (SAMA UNTUK KETIGA SHEET)
------------------------------------
   126 x 169 piksel

   afif-aligned.png      7 kolom x 5 baris
                         baris 1-3 : 6 frame
                         baris 4-5 : 7 frame
   falling-aligned.png  6 kolom x 3 baris
                         baris 1 : 6 frame, baris 2-3 : 5 frame
   hit-aligned.png      6 kolom x 5 baris
                         baris 1 : 6 frame
                         baris 2 : 4 frame
                         baris 3 : 5 frame
                         baris 4 : 6 frame
                         baris 5 : 5 frame

TITIK PIVOT / KAKI
------------------
Semua frame di ketiga sheet memakai titik kaki yang sama:
   x = 63 px  (tepat di tengah sel, 126/2)
   y = 132 px dari atas sel (37 px dari bawah sel)

Jadi kalau satu animasi diganti dengan animasi lain, karakternya tidak
akan bergeser naik/turun atau ke kiri/kanan.

CARA PAKAI DI GODOT
-------------------
Opsi A - langsung dari sheet:
   1. Import PNG, set Texture Filter = Nearest.
   2. Buat AnimatedSprite2D -> SpriteFrames.
   3. "Add frames from Sprite Sheet".
   4. Isi Horizontal = jumlah kolom, Vertical = jumlah baris (lihat tabel).
   5. Biarkan Centered = true.
      Karena kaki ada 47,5 px di bawah pusat sel dan tepat di tengah
      horizontal, semua animasi otomatis sejajar.

Opsi B - per baris (paling mudah):
   1. Pakai file di folder rows\.
   2. "Add frames from Sprite Sheet".
   3. Horizontal = jumlah frame pada baris itu, Vertical = 1.
   4. Atur FPS sesuai selera (contoh 8-12 FPS).

PEMETAAN YANG DIPAKAI DI GAME (player.tscn)
------------------------------------------
   idle   -> afif-aligned.png     baris 1, 6 frame,  5 FPS
   run    -> afif-aligned.png     baris 3, 6 frame,  8 FPS
   jump   -> falling-aligned.png  baris 1, 6 frame,  8 FPS
   fall   -> falling-aligned.png  baris 2, 5 frame,  8 FPS
   hit    -> falling-aligned.png  baris 3, 5 frame,  8 FPS
   2jump  -> afif-aligned.png     baris 5, 7 frame,  8 FPS

   AnimatedSprite2D di player.tscn memakai:
       scale  = 0.4
       offset = (0, -46.5)   -> telapak kaki tepat di titik origin (y = 0)
       (catatan: offset dihitung dalam pixel lokal, jadi ikut dikali
        scale 0.4. -46.5 * 0.4 = -18.6 px di dunia.)

   CollisionShape2D:
       CapsuleShape2D radius 9, height 30
       position (0, -15)     -> bagian bawah hitbox tepat di kaki (y = 0)

   Baris afif 4 (berguling / bola berputar) belum dipakai di game;
   bisa dipakai nanti untuk animasi roll atau spin.

CATATAN
-------
- File sumber tidak ditimpa; semua hasil adalah file baru.
- falling baris 3 frame 5 hanya berupa kepala karena gambar sumbernya
  memang terpotong di bagian bawah (tidak ada badan untuk dipulihkan).
- afif baris 5 adalah animasi berguling; efek pusaran sengaja ikut
  disertakan dan berada di bawah bola.
- Urutan frame mengikuti urutan kiri-ke-kanan pada gambar sumber.
