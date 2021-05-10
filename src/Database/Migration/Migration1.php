<?php

/**
 * Migration:   1
 * Started:     xxxx-xx-xx
 */

namespace Nails\Database\Migration\App;

use Nails\Auth;
use Nails\Cdn;
use Nails\Cms;
use Nails\Common\Console\Migrate\Base;
use Nails\Common\Exception\FactoryException;
use Nails\Common\Exception\ModelException;
use Nails\Factory;
use Nails\Environment;

class Migration1 extends Base
{
    /**
     * The ID of the SuperUser group
     *
     * @var int
     */
    private $iGroupSuperuserId;

    /**
     * The ID of the administrator group
     *
     * @var int
     */
    private $iGroupAdminId;

    /**
     * The ID of the member group
     *
     * @var int
     */
    private $iGroupMemberId;

    // --------------------------------------------------------------------------

    /**
     * Execute the migration
     *
     * @throws FactoryException
     * @throws ModelException
     */
    public function execute(): void
    {
        $this
            ->addSettings()
            ->addCmsBlocks()
            ->addCmsAreas()
            ->addCmsPages()
            ->addCmsMenu()
            ->addCdnBuckets()
            ->addUserGroups()
            ->addUsers();
    }

    // --------------------------------------------------------------------------

    /**
     * Add app settings
     *
     * @return $this
     * @throws FactoryException
     */
    private function addSettings(): self
    {
        $aSetting = [
            // '{{SETTINGS_GROUP}}' => [
            //     '{{SETTING_KEY}}',
            // ],
        ];

        $aEncrypted = [
            // '{{SETTINGS_GROUP}}' => [
            //     '{{SETTING_KEY}}',
            // ],
        ];

        foreach ($aSetting as $sGroup => $aValues) {
            foreach ($aValues as $sKey => $mValue) {
                setAppSetting($sKey, $sGroup, $mValue, in_array($sKey, $aEncrypted[$sGroup] ?? []));
            }
        }

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Add initial CMS Blocks
     *
     * @return $this
     * @throws FactoryException
     * @throws ModelException
     */
    protected function addCmsBlocks(): self
    {
        $aBlocks = [
            [
                'label' => 'Default Site Meta Description',
                'type'  => 'plaintext',
                'value' => '',
            ],
            [
                'label' => 'Default Site Meta Image',
                'type'  => 'image',
                'value' => '',
            ],
        ];

        /** @var Cms\Model\Block $oModel */
        $oModel = Factory::model('Block', 'nails/module-cms');
        foreach ($aBlocks as $aBlock) {
            $aBlock['slug'] = url_title($aBlock['label'], '-', true);
            $oModel->create($aBlock);
        }

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Add initial CMS Areas
     *
     * @return $this
     * @throws FactoryException
     * @throws ModelException
     */
    protected function addCmsAreas(): self
    {
        $sDefaultAreaData = json_encode([
            [
                'slug' => 'html',
                'data' => [
                    'body' => implode(PHP_EOL, [
                        '<p style="padding: 2rem; border:1px solid #ccc; background: #eee;">',
                        'This CMS area can be edited in the CMS',
                        '</p>',
                    ]),
                ],
            ],
        ]);

        $aAreas = [
            [
                'label'       => 'A CMS Area',
                'description' => 'A sample CMS area',
                'widget_data' => $sDefaultAreaData,
            ],
        ];

        /** @var Cms\Model\Area $oModel */
        $oModel = Factory::model('Area', 'nails/module-cms');
        foreach ($aAreas as $aArea) {
            $oModel->create($aArea);
        }

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Add initial CMS Pages
     *
     * @return $this
     * @throws FactoryException
     */
    protected function addCmsPages(): self
    {
        $sDefaultPageBody = json_encode([
            'mainbody' => [
                [
                    'slug' => 'html',
                    'data' => [
                        'body' => implode(PHP_EOL, [
                            '<p style="padding: 2rem; border:1px solid #ccc; background: #eee;">',
                            'This CMS page can be edited in the CMS',
                            '</p>',
                        ]),
                    ],
                ],
            ],
        ]);

        $aPages = [
            [
                'title'         => 'A Sample CMS PAge',
                'template'      => 'fullwidth',
                'template_data' => $sDefaultPageBody,
            ]
        ];

        /** @var Cms\Model\Page $oModel */
        $oModel = Factory::model('Page', 'nails/module-cms');
        foreach ($aPages as $aPage) {
            $iId = $oModel->create($aPage);
            $oModel->publish($iId);
        }

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Add initial CMS Menus
     *
     * @return $this
     * @throws FactoryException
     */
    protected function addCmsMenu(): self
    {
        $aMenus = [
            [
                'label'       => 'A sample CMS Menu',
                'description' => 'A sample CMS Menu',
                'items'       => [
                    [
                        'id'      => null,
                        'label'   => 'A Sample Menu Item',
                        'url'     => null,
                        'page_id' => null,
                    ],
                ],
            ],
        ];

        /** @var Cms\Model\Menu $oModel */
        $oModel = Factory::model('Menu', 'nails/module-cms');
        foreach ($aMenus as $aMenu) {
            $oModel->create($aMenu);
        }

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Adds initial CDN buckets
     *
     * @return $this
     * @throws FactoryException
     * @throws ModelException
     */
    protected function addCdnBuckets(): self
    {
        $aBuckets = [
            [
                'label'     => 'Seed',
                'is_hidden' => true,
            ],
        ];

        /** @var Cdn\Model\Bucket $oModel */
        $oModel = Factory::model('Bucket', Cdn\Constants::MODULE_SLUG);
        foreach ($aBuckets as $aBucket) {
            $oModel->create($aBucket);
        }

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Adds/resets user groups
     *
     * @return $this
     * @throws FactoryException
     * @throws ModelException
     */
    protected function addUserGroups()
    {
        /** @var Auth\Model\User\Group $oGroupModel */
        $oGroupModel = Factory::model('UserGroup', Auth\Constants::MODULE_SLUG);

        $this->query(sprintf('TRUNCATE %s;', $oGroupModel->getTableName()));

        $this->iGroupSuperuserId = $oGroupModel->create([
            'slug'             => 'superuser',
            'label'            => 'Superuser',
            'description'      => 'Superuser\'s have complete access to all modules in admin regardless of specific module allocations.',
            'default_homepage' => '/admin',
            'acl'              => json_encode([
                'admin:superuser',
            ]),
        ]);

        $this->iGroupAdminId = $oGroupModel->create([
            'slug'             => 'admin',
            'label'            => 'Administrator',
            'description'      => 'Administrators have access to specific areas within admin.',
            'default_homepage' => '/admin',
            'acl'              => json_encode([
                //  @todo (Pablo - 2019-12-12) - Change to explicit permissions
                'admin:superuser',
            ]),
        ]);

        $this->iGroupMemberId = $oGroupModel->create([
            'slug'             => 'member',
            'label'            => 'Member',
            'description'      => 'Members have no access to admin.',
            'default_homepage' => '/',
            'is_default'       => true,
        ]);

        return $this;
    }

    // --------------------------------------------------------------------------

    /**
     * Adds initial users
     *
     * @return $this
     * @throws FactoryException
     */
    protected function addUsers(): self
    {
        $aUsers = [
            $this->iGroupSuperuserId => [
                ['Pablo', 'de la Peña', 'p@shedcollective.org', 'pablo'],
                ['Gary', 'Duncan', 'g@shedcollective.org', 'gary'],
                ['Shaun', 'McWhinnie', 'shaun@shedcollective.org', 'shaun'],
                ['Michaela', 'Drake', 'michaela@shedcollective.org', 'michaela'],
            ],
            $this->iGroupAdminId     => [],
            $this->iGroupMemberId    => [],
        ];

        /** @var Auth\Model\User $oModel */
        $oModel = Factory::model('User', 'nails/module-auth');
        foreach ($aUsers as $iUserGroup => $aUserData) {
            foreach ($aUserData as $aUser) {
                [$sFirst, $sLast, $sEmail, $sUsername] = $aUser;
                $oModel->create(
                    [
                        'first_name' => $sFirst,
                        'last_name'  => $sLast,
                        'email'      => $sEmail,
                        'username'   => $sUsername,
                        'group_id'   => $this->iGroupSuperuserId,
                        'temp_pw'    => Environment::is(Environment::ENV_PROD),
                        'password'   => Environment::not(Environment::ENV_PROD) ? 'password' : null,
                    ],
                    false
                );
            }
        }
        return $this;
    }
}
