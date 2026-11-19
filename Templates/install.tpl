	latest="$(curl -fsSL -o /dev/null -w '%{url_effective}' -L https://github.com/tofuutils/tenv/releases/latest)" && \
	tag="${latest##*/}" && \
	case "$(uname -m)" in \
		x86_64) tenv_arch=x86_64 ;; \
		aarch64|arm64) tenv_arch=arm64 ;; \
		armv7l) tenv_arch=armv7 ;; \
		i386|i686) tenv_arch=i386 ;; \
		*) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;; \
	esac && \
	curl -fsSL -o /tmp/tenv.tar.gz "https://github.com/tofuutils/tenv/releases/download/${tag}/tenv_${tag}_Linux_${tenv_arch}.tar.gz" && \
	mkdir -p /tmp/tenv /root/.tenv && \
	tar -xzf /tmp/tenv.tar.gz -C /tmp/tenv && \
	for bin in tenv tf tofu terraform terragrunt terramate atmos; do \
		mv "/tmp/tenv/${bin}" /usr/local/bin/; \
	done && \
	rm -rf /tmp/tenv /tmp/tenv.tar.gz && \
	printf '%s\n' 'export TENV_ROOT=/root/.tenv' >> /root/.bashrc && \
