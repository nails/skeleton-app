<?php

namespace App\Seed\DefinedEntity;

use Nails\Cdn\Constants;
use Nails\Common\Console\Seed\Model;
use Nails\Factory;

class Cdn extends Model
{
    const CONFIG_PRIORITY     = 0;
    const CONFIG_NUM_PER_SEED = 10;

    // --------------------------------------------------------------------------

    public function execute()
    {
        /** @var \Nails\Cdn\Service\Cdn $oCdn */
        $oCdn = Factory::service('Cdn', Constants::MODULE_SLUG);

        $aImages = [
            'seed' => [[2000, 2800], [2800, 2000]],
        ];

        foreach ($aImages as $sBucket => $aSize) {

            [$aWidth, $aHeight] = $aSize;
            $iVersion = rand(0, 1);
            $iWidth   = getFromArray($iVersion, $aWidth);
            $iHeight  = getFromArray($iVersion, $aHeight);

            $sUrl = sprintf(
                'https://source.unsplash.com/random/%sx%s',
                $iWidth,
                $iHeight
            );

            for ($i = 0; $i < static::CONFIG_NUM_PER_SEED; $i++) {
                $oCdn->objectCreate($sUrl, $sBucket);
            }
        }
    }
}
