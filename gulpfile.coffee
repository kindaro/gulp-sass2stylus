gulp = require ('gulp')
coffee = require ('gulp-coffee')

gulp.task 'default', ['coffee']

gulp.task 'gulpfile',
    ->
        gulp.src './gulpfile.coffee'
        .pipe coffee {bare: true}
        .pipe gulp.dest './'

gulp.task 'coffee',
    ->
        gulp.src ['./src/**/*.coffee', '!./src/_*/**/*']
        .pipe coffee {}
        .pipe gulp.dest './'
