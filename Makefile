run: outdir
	cd outdir/root/src && qemu-system-i386 -snapshot -serial stdio -kernel tccboot \
		-initrd initrd.img -append "root=/dev/hda" -hda example.romfs

outdir: linux-2.4.26.tar.gz
	docker build . --platform=linux/i386 -o outdir

linux-2.4.26.tar.gz:
	wget -c https://mirrors.edge.kernel.org/pub/linux/kernel/v2.4/linux-2.4.26.tar.gz

clean:
	rm -rf outdir
