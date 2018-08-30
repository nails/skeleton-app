<?php

namespace App\Controller;

use Nails\Factory;

class Base extends \Nails\Common\Controller\Base
{
    /**
     * Construct the controller
     * Code that is defined in here is executed before the controller which
     * is being called by the URL. It is common to load site-wide assets in
     * here, or to define site-wide variables.
     */
    public function __construct()
    {
        /**
         * It is important to call the parent constructor in order to ensure
         * expected functionality is inherited properly.
         */

        parent::__construct();

        $this->loadAssets();
        $this->loadMeta();
    }

    // --------------------------------------------------------------------------

    protected function loadAssets()
    {
        $oAsset = Factory::service('Asset');

        //  Load CSS from the app's `assets/build/css` directory
        $oAsset->load('app.css');

        //  Load JS from the app's `assets/build/js` directory
        $oAsset->load('app.js');
    }

    private function loadMeta()
    {
        $oMeta = Factory::service('Meta');

         // Favicons
        $oMeta->addRaw([
            'tag'  => 'link',
            'rel'  => 'icon',
            'href' => site_url('favicon.ico'),
        ]);
        $oMeta->addRaw([
            'tag'   => 'link',
            'rel'   => 'icon',
            'type'  => 'image/png',
            'href'  => site_url('assets/img/favicons/favicon-16x16.png'),
            'sizes' => '16x16',
        ]);
        $oMeta->addRaw([
            'tag'   => 'link',
            'rel'   => 'icon',
            'type'  => 'image/png',
            'href'  => site_url('assets/img/favicons/favicon-32x32.png'),
            'sizes' => '32x32',
        ]);
        $oMeta->addRaw([
            'tag'   => 'link',
            'rel'   => 'apple-touch-icon',
            'sizes' => '180x180',
            'href'  => site_url('assets/img/favicons/apple-touch-icon.png'),
        ]);
        $oMeta->addRaw([
            'tag'  => 'link',
            'rel'  => 'mask-icon',
            'type' => 'image/svg+xml',
            'href' => site_url('assets/img/favicons/safari-pinned-tab.svg'),
        ]);

        //  Other meta tags
        $oMeta->add('apple-mobile-web-app-title', APP_NAME);
        $oMeta->add('application-name', APP_NAME);
        $oMeta->add('theme-color', '#ffffff”');

        $oMeta->add('description', '@todo.');

        // --------------------------------------------------------------------------

        // Open graph meta
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:title',
            'content'  => APP_NAME,
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:type',
            'content'  => 'website',
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:locale',
            'content'  => 'en_GB',
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:image',
            'content'  => site_url('/assets/img/share/facebook.jpg'),
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:image:width',
            'content'  => 1200,
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:image:height',
            'content'  => 630,
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:site_name',
            'content'  => APP_NAME,
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:url',
            'content'  => site_url(),
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'og:description',
            'content'  => '@todo',
        ]);
        $oMeta->addRaw([
            'tag'      => 'meta',
            'property' => 'fb:app_id',
            'content'  => '@todo',
        ]);
        $oMeta->addRaw([
            'tag'     => 'meta',
            'name'    => 'theme-color',
            'content' => '#ffffff',
        ]);

        // --------------------------------------------------------------------------
        // Twitter card config

        $oMeta->addRaw([
            'name'    => 'twitter:card',
            'content' => 'summary_large_image',
        ]);
        $oMeta->addRaw([
            'name'    => 'twitter:site',
            'content' => '@todo',
        ]);
        $oMeta->addRaw([
            'name'    => 'twitter:title',
            'content' => '@todo',
        ]);
        $oMeta->addRaw([
            'name'    => 'twitter:description',
            'content' => '@todo.',
        ]);
        $oMeta->addRaw([
            'name'    => 'twitter:image',
            'content' => site_url('/assets/img/share/twitter.jpg'),
        ]);

    }
}
