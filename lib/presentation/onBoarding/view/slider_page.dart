part of 'on_boarding_view.dart';

class SliderPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const SliderPage({
    Key? key,
    required SliderObject sliderObject,
  })  : _sliderObject = sliderObject,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_sliderObject.title, style: Theme.of(context).textTheme.titleLarge,),
        const SizedBox(
          height: AppSize.s25,
        ),
        Text(_sliderObject.supTitle, style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),
        const SizedBox(
          height: AppSize.s50,
        ),
        SvgPicture.asset(_sliderObject.imagePath),
      ],
    );
  }
}
