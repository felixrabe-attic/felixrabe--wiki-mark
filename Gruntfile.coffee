module.exports = (grunt) ->

  grunt.initConfig
    simplemocha:
      dev:
        src: 'test/**/*.coffee'
        options:
          compilers: 'coffee:coffee-script'
          # reporter: 'spec'
          colors: false
    watch:
      options: atBegin: true
      scripts:
        files: ['**/*.coffee']
        tasks: ['test']

  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'test', ['simplemocha']
