# NexoPol 🌼🐝

Aplicación educativa de polinizadores para productores de Nicaragua, lista para publicarse gratis en **GitHub Pages**. Incluye las secciones Inicio, Explorar, Prácticas, Mi campo, Comunidad, Aprender y Valor agregado, además del logo de la **florcita amarilla** como ícono de instalación.

## 1. Publicar la aplicación con GitHub (sin programación)

1. Entrá a https://github.com y creá una cuenta o iniciá sesión.
2. Tocá **New repository**, nombralo `NexoPol` y seleccioná **Public**.
3. En el repositorio elegí **Add file → Upload files** y subí **todo el contenido de esta carpeta**, no solo el archivo HTML. Deben quedar `index.html`, `assets/`, `config.js`, `supabase/`, etc. en la raíz.
4. Confirmá con **Commit changes**.
5. Abrí **Settings → Pages → Build and deployment → Deploy from a branch**. Seleccioná `main` y `/(root)` y guardá.
6. Esperá a que GitHub termine de publicar. Abrí `https://TU_USUARIO.github.io/NexoPol/`.

Si nombrás el repositorio de otra manera, cambia la última parte de la URL.

## 2. Instalar NexoPol en el celular

Abrí la URL publicada en **Chrome para Android → ⋮ → Añadir a pantalla principal / Instalar aplicación**. Aparecerá el ícono de la flor amarilla. Esta es una **PWA** instalable y no un APK nativo. Los contenidos precargados se pueden consultar sin conexión tras la primera carga. Publicaciones compartidas requieren internet.

## 3. Convertir Comunidad en un foro real para todos

GitHub Pages hospeda archivos estáticos; **no es una base de datos de publicaciones**. Para que los productores de distintos teléfonos vean los mismos aportes:

1. Creá un proyecto en [Supabase](https://supabase.com/).
2. En **Authentication → Providers / Sign-in**, activá el **inicio de sesión anónimo** (*Anonymous Sign-Ins*) y definí controles contra abuso. Esto es importante para evitar spam.
3. Abrí **SQL Editor** y ejecutá el contenido de [`supabase/schema.sql`](supabase/schema.sql).
4. Abrí el archivo [`config.js`](config.js) en GitHub y colocá:

```js
window.NEXOPOL_CONFIG = {
  supabaseUrl: "https://TU-PROYECTO.supabase.co",
  supabaseAnonKey: "TU_CLAVE_PUBLICA_PUBLISHABLE_O_ANON"
};
```

5. Guardá el cambio con **Commit changes** y recargá la página (puede tardar un minuto en actualizarse).
6. Entrá a **Comunidad** e iniciá una publicación. Revisá desde otro teléfono que aparezca para ambos usuarios.

**Importante:** solo se pueden poner claves **públicas** publishable / anon en `config.js`. **Nunca** incluyás `service_role`, `sb_secret_...`, contraseña ni otra clave de administrador: GitHub Pages es público. Las reglas de acceso (RLS) del SQL deben mantenerse habilitadas.

Antes de invitar a toda Nicaragua necesitás política de privacidad, moderación, reportes, controles anti-spam y revisión de términos de uso. Los datos de nombre y comunidad se muestran en el foro; no recolectés teléfonos ni direcciones privadas de participantes.

## 4. Personalización

- Nombre o color: `index.html` y `assets/styles.css`.
- Logo en la esquina superior e ícono instalado: `assets/logo-flor.svg`, `assets/icon-192.png` y `assets/icon-512.png`.
- Información, recetas y funcionamiento: `assets/app.js`.
- Fotografías: archivos `assets/*.webp` y referencias en `assets/images.js`.
- Clave del foro: `config.js`.
- Cuando actualicés imágenes/archivos, subí también la nueva versión y cambiá `nexopol-app-v1` por `nexopol-app-v2` en `service-worker.js` para renovar la caché en celulares.

## 5. Probarla en computadora

Abrí una terminal dentro de esta carpeta y ejecutá:

```bash
python -m http.server 8000
```

Después abrí http://localhost:8000 en tu navegador. Esto es mejor que hacer doble clic en `index.html`, porque las PWA necesitan un servidor local o HTTPS.

## Qué es real y qué falta

**Sí funciona como sitio web:** navegación, información de especies, prácticas científicas, recetas, cálculos, perfil y registros de observación locales. El logo floral se instala como ícono. **No está garantizado aún:** sincronización del foro, copias de seguridad de datos locales, moderación profesional, validación agronómica de proyectos experimentales ni publicación en las tiendas de aplicaciones. El modo compartido funciona solo al configurar Supabase correctamente.

**NexoVar Bio** se presenta como prototipo de investigación; no es un tratamiento autorizado para colmenas. Los montos económicos son orientativos, no cotizaciones de mercado.
