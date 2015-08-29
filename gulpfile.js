var coffee, gulp;

gulp = require('gulp');

coffee = require('gulp-coffee');

gulp.task('default', ['coffee']);

gulp.task('gulpfile', function() {
  return gulp.src('./gulpfile.coffee').pipe(coffee({
    bare: true
  })).pipe(gulp.dest('./'));
});

gulp.task('coffee', function() {
  return gulp.src(['./src/**/*.coffee', '!./src/_*/**/*']).pipe(coffee({})).pipe(gulp.dest('./'));
});
