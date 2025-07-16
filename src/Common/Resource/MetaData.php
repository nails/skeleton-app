<?php

namespace App\Common\Resource;

class MetaData extends \Nails\Common\Resource\MetaData
{
    public function __construct(self|\stdClass|array $resource = [])
    {
        parent::__construct($resource);
        $iImage = cmsBlock('default-site-meta-image');
        $this
            ->setDescription(cmsBlock('default-site-meta-description'))
            ->setImageUrl($iImage ? cdnServe($iImage) : '');
    }
}
