const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = ()  => {

    // Set a valid environment - will default to production if an invalid value is set
    const VALID_ENVIRONMENTS = ['production', 'development', 'none'];
    const ENVIRONMENT = process.env.NODE_ENV.toLowerCase();
    let mode = 'production';

    if (VALID_ENVIRONMENTS.includes(ENVIRONMENT)) {
        mode = ENVIRONMENT;
    }

    // Check for windows.
    const IS_WINDOWS = process.platform === 'win32';

    return {
        /**
         * Mode
         * - Webpack 4 will do a number of modification tasks for you depending on the mode
         */
        mode: mode,
        /**
         * WatchOptions
         * - poll - as some windows environments cant watch file systems, use poll to reload on file changes
         */
        watchOptions: {
            poll: IS_WINDOWS ? 2000 : false
        },
        /**
         * Entry
         * - Define starting files for compilation here - each will be compiled as `<entry-key>.js`
         */
        entry: {
            app: path.resolve(__dirname, 'assets/js/app.js')
        },
        /**
         * Output
         * - All files will be output with their entry-key as the name
         */
        output: {
            path: path.resolve(__dirname, 'assets/build/js'),
            filename: '[name].js'
        },
        /**
         * Devtool
         * - Controls how source maps are generated
         */
        devtool: 'cheap-source-map',
        /**
         * Module
         * - Does the compilation!
         * - Documentation on this can be found https://webpack.js.org/configuration/module/
         */
        module: {
            rules: [
                /**
                 * Babel-loader - for use with older browsers we use babel-preset-env for compilation. See .browserslistrc for details on what browsers are targetted.
                 */
                {
                    test: /\.js$/,
                    loader: 'babel-loader',
                    options: {
                        presets: [
                            [
                                '@babel/preset-env',
                                {
                                    useBuiltIns: 'entry',
                                    modules: false,
                                    corejs: 3
                                }
                            ]
                        ]
                    }
                },
                {
                    test: /\.(css|scss|sass)$/,
                    use: [
                        MiniCssExtractPlugin.loader,
                        'css-loader',
                        {
                            loader: 'postcss-loader',
                            options: {
                                postcssOptions: {
                                    plugins: [
                                        require('autoprefixer')
                                    ]
                                }
                            }
                        },
                        {
                            loader: 'sass-loader',
                            options: {
                                sourceMap: true
                            }
                        }
                    ]
                },
            ]
        },
        /**
         * Optimization
         * - Split chunks - to reduce bundle size, we split out all library/node_module bundles to a seperate vendor.js file
         */
        optimization: {
            splitChunks: {
                cacheGroups: {
                    vendor: {
                        test: /[\\/]node_modules[\\/].*\.js$/,
                        chunks: 'initial',
                        name: 'vendor',
                        enforce: true
                    }
                }
            }
        },
        /**
         * Plugins
         * MiniCssExtractPlugin - compile css down to a seperate CSS file
         */
        plugins: [
            new MiniCssExtractPlugin({
                filename: '../../build/css/[name].css',
            }),
        ].filter(Boolean)
    };
};
