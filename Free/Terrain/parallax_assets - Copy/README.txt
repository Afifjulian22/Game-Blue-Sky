PAKET ASSET PARALLAX - Hutan Pegunungan
========================================
Resolusi : 736 x 414 px
Format   : PNG RGBA (latar transparan)
Sumber   : hasil pemisahan dari satu gambar ilustrasi

URUTAN LAYER (belakang -> depan)
--------------------------------
01_sky.png             langit (menutupi seluruh frame)
02_clouds.png          awan
03_mountains_far.png   gunung, perbukitan kabut, hutan jauh
04_treeline.png        deretan pohon pinus
05_ground.png          rumput + tanah
06_rock_bush.png       batu dan semak
07_tree_left.png       pohon besar kiri
08_tree_right.png      pohon besar kanan

CARA PAKAI
----------
1. Susun layer sesuai urutan di atas pada posisi yang sama (0,0).
2. Beri kecepatan geser horizontal yang berbeda tiap layer.
   Contoh kecepatan relatif yang dipakai di preview_parallax.gif:
       langit        0
       awan         24
       gunung       10
       pinus        22
       tanah        34
       batu/semak   38
       pohon        46
   (makin kecil nilainya, makin jauh kesan kedalamannya)
3. Layer bisa juga digeser sedikit vertikal untuk efek tambahan.
4. Untuk kebutuhan 2x, scale dengan Nearest Neighbor agar tetap tajam.

FILE PREVIEW
------------
preview_stacked.png  hasil susun semua layer (posisi asli)
preview_layers.png   pratinjau tiap layer di atas kotak-kotak transparan
preview_parallax.gif animasi contoh efek parallax

CATATAN
-------
- Beberapa area di belakang pohon/awan diisi perkiraan (kabut) karena
  pada gambar asli tertutup objek. Ini normal untuk asset parallax.
- Jika ingin gerakan parallax yang sangat ekstrem, perlebar sedikit
  area kabut di belakang objek depan.
